use AuthorityWeb
go
if object_id('dbo.uspSetFixCheckEmailCertKey') is null
	exec ('create procedure dbo.uspSetFixCheckEmailCertKey as select 1')
--	drop procedure dbo.uspSetFixCheckEmailCertKey
go
/******************************************************************************
	Name		: dbo.uspSetFixCheckEmailCertKey
	Description	: 이메일 인증 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetFixCheckEmailCertKey
(	@pCertNo		bigint
,	@oAccountNo		bigint		output
,	@oAccountId		varchar(50)	output
,	@oEmail			varchar(50)	output
,	@oEntryTime		datetime	output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vRequestNo		tinyint		-- 0: 아이디찾기, 1: 비밀번호찾기, 2: 이메일인증
		,	@vSendTime		datetime
		,	@vFinishTime	datetime
		,	@vErrorMsg		nvarchar(max)
	select	@oAccountNo	= 0
		,	@oAccountId	= ''
		,	@oEmail		= ''
		,	@oEntryTime	= ''
		,	@oReturnNo	= 0

	select	@oAccountNo		= cAccountNo
		,	@oEmail			= cEmail
		,	@vRequestNo		= cRequestNo
		,	@vSendTime		= cCreateTime
		,	@vFinishTime	= cFinishTime
	from	dbo.tEmailCert
	where	cCertNo			= @pCertNo

	-- 1.발송된 인증키가 존재하지 않습니다.
	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end

	-- 2.이메일 인증 대기시간이 20분이 지났습니다.
	if datediff(minute,@vSendTime,getdate()) > 20
	begin
		set @oReturnNo = 2
		return 2
	end

	-- 3.이메일 인증값 상태 체크. 이미 인증된 인증키 입니다.
	if @vFinishTime is not null
	begin
		set @oReturnNo = 3
		return 3
	end


	-- 4.회원상태 확인
	select	@oAccountId	= cAccountId
		,	@oEntryTime	= cCreateTime
	from	dbo.tAccountInfo
	where	cAccountNo	= @oAccountNo
		and	cDeleteTime	is null

	if @@rowcount = 0
	begin
		set @oReturnNo = 4
		return 4
	end


	begin try
		begin tran
			set @oReturnNo = 6
			-- 이메일 인증 이면..
			if @vRequestNo = 2
			begin
				update	a
				set		cCertfyTime	= getdate()
				from	dbo.tAccountInfo as a
				where	cAccountNo	= @oAccountNo
			end


			set @oReturnNo = 7
			update	a
			set		cFinishTime	= getdate()
			from	dbo.tEmailCert as a
			where	cCertNo		= @pCertNo

			-- 발송된 인증키가 존재하지 않습니다.
			if @@rowcount = 0
			begin
				select	@oReturnNo = -7
					,	@vErrorMsg = '@pCertNo = '+ rtrim(@pCertNo)
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

grant execute on dbo.uspSetFixCheckEmailCertKey to [sawebuser]
go

