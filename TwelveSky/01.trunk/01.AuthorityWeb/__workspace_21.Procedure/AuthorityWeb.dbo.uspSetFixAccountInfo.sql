use AuthorityWeb
go
if object_id('dbo.uspSetFixAccountInfo') is null
	exec ('create procedure dbo.uspSetFixAccountInfo as select 1')
--	drop procedure dbo.uspSetFixAccountInfo
go
/******************************************************************************
	Name		: dbo.uspSetFixAccountInfo
	Description	: 회원정보 변경
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixAccountInfo
(	@pAccountNo		bigint
,	@pNickName		nvarchar(20)
,	@pExts			char(3)
,	@pBirthDay		smalldatetime
,	@pIsEmail		bit
,	@pIsPhoto		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	begin try
		set @oReturnNo = 1
		update	a
		set		cNickName		= @pNickName
			,	cExts			= case @pIsPhoto when 0 then null else @pExts end
			,	cBirthDay		= @pBirthDay
			,	cIsEmail		= @pIsEmail
			,	cIsPhoto		= @pIsPhoto
			,	cModifyTime		= getdate()
		from	dbo.tAccountInfo as a
		where	cAccountNo		= @pAccountNo
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

grant execute on dbo.uspSetFixAccountInfo to [sawebuser]
go

