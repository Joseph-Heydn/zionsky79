use AuthorityWeb
go
if object_id('dbo.uspGetCheckEmailCertKey') is null
	exec ('create procedure dbo.uspGetCheckEmailCertKey as select 1')
--	drop procedure dbo.uspGetCheckEmailCertKey
go
/******************************************************************************
	Name		: dbo.uspGetCheckEmailCertKey
	Description	: 이메일 인증 체크
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetCheckEmailCertKey
(	@pCertKey		char(36)
,	@oCertNo		bigint		output
,	@oRequestNo		tinyint		output	-- 0: 아이디찾기, 1: 비밀번호찾기, 2: 유저 이메일인증
,	@oReturnNo		int			output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vAccountNo	bigint
		,	@vStartTime	datetime
	select	@oRequestNo	= 0
		,	@oReturnNo	= 0

	select	top 1
			@oCertNo	= cCertNo
		,	@oRequestNo	= cRequestNo
		,	@vStartTime	= cCreateTime
	from	dbo.tEmailCert
	where	cCertKey	= @pCertKey
	order by cCertNo desc

	-- 1.발송된 인증키가 존재하지 않습니다.
	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end

	-- 20분 초과 하면 재인증해야 함.
	if dateadd(minute,20,@vStartTime) < getdate()
	begin
		set @oReturnNo = 2
		return 2
	end


	-- 유저 이메일 인증
	if @oRequestNo = 2
	begin
		begin try
			begin tran
				set @oReturnNo = 3
				update	a
				set		@vAccountNo		= cAccountNo
					,	cFinishTime		= getdate()
				from	dbo.tEmailCert as a
				where	cCertNo			= @oCertNo

				set @oReturnNo = 4
				update	a
				set		cCertfyTime		= getdate()
				from	dbo.tAccountInfo as a
				where	cAccountNo		= @vAccountNo
			commit tran
		end try

		begin catch
			if @@trancount > 0 rollback tran

			exec dbo.uspSetNewErrorLog
					@pPrintMsg	= 0
				,	@oErrorNo	= 0

			return @oReturnNo
		end catch
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetCheckEmailCertKey to [sawebuser]
go

