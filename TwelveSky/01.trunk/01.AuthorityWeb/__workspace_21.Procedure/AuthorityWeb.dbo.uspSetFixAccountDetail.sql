use AuthorityWeb
go
if object_id('dbo.uspSetFixAccountDetail') is null
	exec ('create procedure dbo.uspSetFixAccountDetail as select 1')
--	drop procedure dbo.uspSetFixAccountDetail
go
/******************************************************************************
	Name		: dbo.uspSetFixAccountDetail
	Description	: api - 게임 데이터 저장
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixAccountDetail
(	@pConsumerKey	char(10)
,	@pAccountNo		bigint
,	@pPlayerNo		bigint
,	@pGameNick		nvarchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare @vGameNo	int
		,	@vErrorMsg	nvarchar(max)
	set @oReturnNo = -1

	select	@vGameNo		= cGameNo
	from	dbo.tConsumerInfo
	where	cConsumerKey	= @pConsumerKey

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	begin try
		begin tran
			set @oReturnNo = 2
			update	a
			set		cPlayerNo		= @pPlayerNo
				,	cGameNick		= @pGameNick
			from	dbo.tGuestConsumer as a
			where	cGameNo			= @vGameNo
				and cAccountNo		= @pAccountNo
				and (	cPlayerNo	is null
					or	cPlayerNo	= @pPlayerNo
					)

			if @@rowcount != 1
			begin
				select	@oReturnNo = -2
					,	@vErrorMsg = '@pConsumerKey = '+ rtrim(@pConsumerKey)
					,	@vErrorMsg += ', @vGameNo = '+ rtrim(@vGameNo)
					,	@vErrorMsg += ', @pAccountNo = '+ rtrim(@pAccountNo)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end
		commit tran
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
go

grant execute on dbo.uspSetFixAccountDetail to [sawebuser]
go

