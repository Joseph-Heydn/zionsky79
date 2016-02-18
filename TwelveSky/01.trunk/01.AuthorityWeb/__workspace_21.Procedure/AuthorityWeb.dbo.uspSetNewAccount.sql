use AuthorityWeb
go
if object_id('dbo.uspSetNewAccount') is null
	exec ('create procedure dbo.uspSetNewAccount as select 1')
--	drop procedure dbo.uspSetNewAccount
go
/******************************************************************************
	Name		: dbo.uspSetNewAccount
	Description	: 회원 가입
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewAccount
(	@pAccountId		varchar(50)
,	@pPassword		char(32)
,	@pNickName		nvarchar(20)
,	@pEmail			varchar(50)
,	@pHostIp		varchar(15)
,	@pEmailAgree	bit
,	@oAccountNo		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	select	@oAccountNo	= 0
		,	@oReturnNo	= -1

	-- 1. 아이디 중복 검사
	if exists ( select 1 from dbo.tAccountInfo where cAccountId = @pAccountId )
	begin
		set @oReturnNo = 2
		return 2
	end

	-- 2. 닉네임 중복 검사
	if exists ( select 1 from dbo.tAccountInfo where cNickName = @pNickName )
	begin
		set @oReturnNo = 3
		return 3
	end


	begin try
		select	@oReturnNo	= 4
			,	@oAccountNo	= next value for dbo.sAccountNo

		insert into dbo.tAccountInfo
			(	cAccountNo
			,	cPublisher
			,	cAccountId
			,	cPassword
			,	cNickName
			,	cEmail
			,	cHostIp
			,	cStatus
			,	cIsEmail
			,	cCreateTime
			)
		values
			(	@oAccountNo
			,	1
			,	@pAccountId
			,	pwdencrypt(@pPassword)
			,	@pNickName
			,	@pEmail
			,	@pHostIp
			,	1
			,	@pEmailAgree
			,	getdate()
			)
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

grant execute on dbo.uspSetNewAccount to [sawebuser]
go

