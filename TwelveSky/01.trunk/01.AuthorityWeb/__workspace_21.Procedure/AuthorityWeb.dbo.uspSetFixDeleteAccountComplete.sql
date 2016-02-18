use AuthorityWeb
go
if object_id('dbo.uspSetFixDeleteAccountComplete') is null
	exec ('create procedure dbo.uspSetFixDeleteAccountComplete as select 1')
--	drop procedure dbo.uspSetFixDeleteAccountComplete
go
/******************************************************************************
	Name		: dbo.uspSetFixDeleteAccountComplete
	Description	: 회원 탈퇴 완료
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixDeleteAccountComplete
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
		return 1
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
			set		b.cDeleteTime	= getdate()
			from	ctetWithdrawLog as a
					inner join
					dbo.tWithdrawLog as b
				on	b.cLogs			= a.cLogs
			where	b.cAccountNo	= @pAccountNo


			set @oReturnNo = 3
			update	a
			set		cStatus		= 99
				,	cDeleteTime	= getdate()
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

grant execute on dbo.uspSetFixDeleteAccountComplete to [sawebuser]
go

