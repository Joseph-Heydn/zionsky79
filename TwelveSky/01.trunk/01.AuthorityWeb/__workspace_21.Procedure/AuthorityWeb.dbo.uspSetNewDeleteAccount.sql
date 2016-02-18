use AuthorityWeb
go
if object_id('dbo.uspSetNewDeleteAccount') is null
	exec ('create procedure dbo.uspSetNewDeleteAccount as select 1')
--	drop procedure dbo.uspSetNewDeleteAccount
go
/******************************************************************************
	Name		: dbo.uspSetNewDeleteAccount
	Description	: 회원 탈퇴 신청
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewDeleteAccount
(	@pAccountNo		bigint
,	@pCategory		smallint
,	@pMemoText		nvarchar(200)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare @vStatus	int
		,	@vPublisher	tinyint
		,	@vAccountId	varchar(20)
	set @oReturnNo = -1

	select	@vPublisher	= cPublisher
		,	@vAccountId	= cAccountId
		,	@vStatus	= cStatus
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo

	-- 이미 탈퇴 신청이 된 회원 입니다.
	if @vStatus = 11
	begin
		set @oReturnNo = 1
		return
	end


	begin try
		begin tran
			set @oReturnNo = 2
			insert into dbo.tWithdrawLog
				(	cLogs
				,	cAccountNo
				,	cPublisher
				,	cAccountId
				,	cCategory
				,	cMemo
				,	cCreateTime
				)
			values
				(	next value for dbo.sDropNo
				,	@pAccountNo
				,	@vPublisher
				,	@vAccountId
				,	nullif(@pCategory,0)
				,	nullif(@pMemoText,'')
				,	getdate()
				)

			set @oReturnNo = 3
			update	a
			set		cStatus		= 11
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

grant execute on dbo.uspSetNewDeleteAccount to [sawebuser]
go

