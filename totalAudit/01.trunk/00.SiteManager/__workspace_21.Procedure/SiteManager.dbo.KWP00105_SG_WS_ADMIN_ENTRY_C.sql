use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_ADMIN_ENTRY_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_ADMIN_ENTRY_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_ADMIN_ENTRY_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_ADMIN_ENTRY_C
	Description	: 관리자 작업 로그 생성
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_ADMIN_ENTRY_C
(	@pAdminId		varchar(20)
,	@pPassword		char(32)
,	@pAdminName		nvarchar(20)
,	@pDeptNo		int
,	@pNoteText		nvarchar(30)
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vIsUsed bit = 0
		,	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_MANGR_LIST
		where	cAdminId = @pAdminId
	)
	begin
		set @oReturnNo = -2
		return
	end

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_MANGR_LIST
		where	cAdminName = @pAdminName
	)
	begin
		set @oReturnNo = -3
		return
	end


	insert into dbo.KWT001_SG_WS_MANGR_LIST
		(	cAdminNo
		,	cAdminId
		,	cPassword
		,	cAdminName
		,	cDeptNo
		,	cIsUsed
		,	cNoteText
		,	cHostIp
		,	cCreateTime
		)
	values
		(	next value for dbo.sAdminNo
		,	@pAdminId
		,	@pPassword
		,	@pAdminName
		,	@pDeptNo
		,	@vIsUsed
		,	@pNoteText
		,	@pHostIp
		,	@vGetDate
		)

	if @@rowcount = 0
	begin
		set @oReturnNo = -4
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @rt int
exec dbo.KWP00105_SG_WS_ADMIN_ENTRY_C
 @pAdminId = 'Tester'
,@pPassword = '55bdf43aa1d13b73de096370fe117314'
,@pAdminName = N'테스트'
,@pDeptNo = 3001001
,@pNoteDesc = N'이거슨 테스트계정 이라능;;'
,@pHostIp = '127.0.0.1'
,@oReturnNo = @rt out

print @rt
*/
go

grant execute on dbo.KWP00105_SG_WS_ADMIN_ENTRY_C to [opwebuser]
go

