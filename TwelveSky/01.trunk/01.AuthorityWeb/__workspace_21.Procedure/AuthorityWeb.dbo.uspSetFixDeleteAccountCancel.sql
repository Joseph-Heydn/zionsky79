use AuthorityWeb
go
if object_id('dbo.uspSetFixDeleteAccountCancel') is null
	exec ('create procedure dbo.uspSetFixDeleteAccountCancel as select 1')
--	drop procedure dbo.uspSetFixDeleteAccountCancel
go
/******************************************************************************
	Name		: dbo.uspSetFixDeleteAccountCancel
	Description	: 회원 탈퇴 취소
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixDeleteAccountCancel
(	@pAccountNo		bigint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare @vStatus int
	set @oReturnNo = -1

	select	@vStatus	= cStatus
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo

	-- 탈퇴 신청 대상자가 아닙니다.
	if @vStatus != 11
	begin
		set @oReturnNo = 1
		return
	end


	begin try
		begin tran
			set @oReturnNo = 2
			;with ctetWithdrawLog as (
				select	max(cLogs) as cLogs
				from	dbo.tWithdrawLog
				where	cAccountNo = @pAccountNo
			)
			update	b
			set		b.cCancelTime	= getdate()
			from	ctetWithdrawLog as a
					inner join
					dbo.tWithdrawLog as b
				on	b.cLogs			= a.cLogs
			where	b.cAccountNo	= @pAccountNo


			set @oReturnNo = 3
			update	a
			set		cStatus		= 1
				,	cDeleteTime	= null
			from	dbo.tAccountInfo as a
			where	cAccountNo	= @pAccountNo
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

grant execute on dbo.uspSetFixDeleteAccountCancel to [sawebuser]
go

