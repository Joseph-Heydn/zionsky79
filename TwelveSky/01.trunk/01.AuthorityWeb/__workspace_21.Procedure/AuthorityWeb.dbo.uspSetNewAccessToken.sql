use AuthorityWeb
go
if object_id('dbo.uspSetNewAccessToken') is null
	exec ('create procedure dbo.uspSetNewAccessToken as select 1')
--	drop procedure dbo.uspSetNewAccessToken
go
/******************************************************************************
	Name		: dbo.uspSetNewAccessToken
	Description	: api - AccessToken 생성
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewAccessToken
(	@pAccountNo		bigint
,	@pGameNo		int
,	@pRefresh		bit
,	@pSecret		char(27)
,	@oToken			char(36)	output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	begin try
		begin tran
			set @oReturnNo = 1
			update	a
			set		cToken =
						case
							when datediff(day,cModifyTime,getdate()) > 7 then newid()
							when @pRefresh = 1 then newid()
							else cToken
						end
				,	cSecret		= @pSecret
				,	cModifyTime	= getdate()
			from	dbo.tGuestConsumer as a
			where	cAccountNo	= @pAccountNo
				and cGameNo		= @pGameNo

			if @@rowcount = 0
			begin
				set @oReturnNo = 2
				insert into dbo.tGuestConsumer
					(	cAccountNo
					,	cGameNo
					,	cToken
					,	cSecret
					,	cModifyTime
					,	cCreateTime
					)
				values
					(	@pAccountNo
					,	@pGameNo
					,	newid()
					,	@pSecret
					,	getdate()
					,	getdate()
					)
			end
		commit tran


		select	@oToken		= cToken
		from	dbo.tGuestConsumer
		where	cAccountNo	= @pAccountNo
			and	cGameNo		= @pGameNo
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @o1 char(36)
,@sp int
,@rt int
exec @sp = dbo.uspSetNewAccessToken
 @pAccountNo = 100000001
,@pGameNo = 20150001
,@pRefresh = 0
,@pSecret = 'aifenfdurafoiuhjageitjooaij'
,@oToken = @o1 out
,@oReturnNo = @rt out

print @o1
print @sp
print @rt
*/
go

grant execute on dbo.uspSetNewAccessToken to [sawebuser]
go

