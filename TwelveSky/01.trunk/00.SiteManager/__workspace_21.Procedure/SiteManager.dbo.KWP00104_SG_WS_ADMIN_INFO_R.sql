use SiteManager
go
if object_id('dbo.KWP00104_SG_WS_ADMIN_INFO_R') is null
	exec ('create procedure dbo.KWP00104_SG_WS_ADMIN_INFO_R as select 1')
--	drop procedure dbo.KWP00104_SG_WS_ADMIN_INFO_R
go
/******************************************************************************
	Name		: dbo.KWP00104_SG_WS_ADMIN_INFO_R
	Description	: 관리자 내용
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00104_SG_WS_ADMIN_INFO_R
(	@pAdminNo		int
,	@oAdminName		nvarchar(20)	output
,	@oAdminId		varchar(20)		output
,	@oDeptNo		int				output
,	@oIsUsed		bit				output
,	@oNoteText		nvarchar(30)	output
,	@oAuthGroup		int				output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oAuthGroup	= 0
		,	@oReturnNo	= -1

	select	@oAdminName		= cAdminName
		,	@oAdminId		= cAdminId
		,	@oDeptNo		= cDeptNo
		,	@oIsUsed		= cIsUsed
		,	@oNoteText		= cNoteText
	from	dbo.KWT001_SG_WS_MANGR_LIST
	where	cAdminNo		= @pAdminNo

	select	@oAuthGroup	= cAuthGroup
	from	dbo.KWT001_SG_WS_MANGR_GROUP_MST
	where	cAdminNo	= @pAdminNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(20)
,@o2 varchar(20)
,@o3 int
,@o4 bit
,@o5 varchar(100)
,@o6 int
,@sp int
exec dbo.KWP00104_SG_WS_ADMIN_INFO_R
 @pAdminNo = 100000001
,@oAdminName = @o1 output
,@oAdminId = @o2 output
,@oDeptNo = @o3 output
,@oIsUsed = @o4 output
,@oNoteText = @o5 output
,@oAuthGroup = @o6 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @o5
print @o6
print @sp
*/
go

grant execute on dbo.KWP00104_SG_WS_ADMIN_INFO_R to [opwebuser]
go

