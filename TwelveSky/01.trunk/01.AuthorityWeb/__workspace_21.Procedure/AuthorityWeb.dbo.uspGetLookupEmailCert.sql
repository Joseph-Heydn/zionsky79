use AuthorityWeb
go
if object_id('dbo.uspGetLookupEmailCert') is null
	exec ('create procedure dbo.uspGetLookupEmailCert as select 1')
--	drop procedure dbo.uspGetLookupEmailCert
go
/******************************************************************************
	Name		: dbo.uspGetLookupEmailCert
	Description	: 인증 확인
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetLookupEmailCert
(	@pAccountNo		bigint
,	@oEmailCert		tinyint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oEmailCert	= case when cCertfyTime is null then 0 else 1 end
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetLookupEmailCert to [sawebuser]
go

