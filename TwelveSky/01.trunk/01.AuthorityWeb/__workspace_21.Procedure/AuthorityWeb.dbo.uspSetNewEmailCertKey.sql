use AuthorityWeb
go
if object_id('dbo.uspSetNewEmailCertKey') is null
	exec ('create procedure dbo.uspSetNewEmailCertKey as select 1')
--	drop procedure dbo.uspSetNewEmailCertKey
go
/******************************************************************************
	Name		: dbo.uspSetNewEmailCertKey
	Description	: 이메일 인증키 생성
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewEmailCertKey
(	@pAccountNo		bigint
,	@pEmail			varchar(50)
,	@pCertKey		char(36)
,	@pRequestNo		tinyint
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
		insert into dbo.tEmailCert
			(	cCertNo
			,	cAccountNo
			,	cEmail
			,	cCertKey
			,	cRequestNo
			,	cCreateTime
			)
		values
			(	next value for dbo.sCertNo
			,	@pAccountNo
			,	@pEmail
			,	@pCertKey
			,	@pRequestNo
			,	getdate()
			)


		-- 이메일 인증을 다시 하는 경우
		if @pRequestNo = 2
		begin
			update	a
			set		cCertfyTime	= null
			from	dbo.tAccountInfo as a
			where	cAccountNo	= @pAccountNo
		end
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

grant execute on dbo.uspSetNewEmailCertKey to [sawebuser]
go

