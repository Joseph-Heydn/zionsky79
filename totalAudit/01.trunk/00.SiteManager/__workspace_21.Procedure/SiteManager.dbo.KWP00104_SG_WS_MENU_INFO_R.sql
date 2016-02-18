use SiteManager
go
if object_id('dbo.KWP00104_SG_WS_MENU_INFO_R') is null
	exec ('create procedure dbo.KWP00104_SG_WS_MENU_INFO_R as select 1')
--	drop procedure dbo.KWP00104_SG_WS_MENU_INFO_R
go
/******************************************************************************
	Name		: dbo.KWP00104_SG_WS_MENU_INFO_R
	Description	: 메뉴 내용
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00104_SG_WS_MENU_INFO_R
(	@pMenuNo		int
,	@oMenuGroup		int				output
,	@oMenuName		nvarchar(10)	output
,	@oMenuUrl		varchar(120)	output
,	@oIsUsed		bit				output
,	@oOrderBy		int				output
,	@oNoteText		nvarchar(30)	output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	@oMenuName	= cMenuName
		,	@oMenuUrl	= cExecUrl
		,	@oMenuGroup	= cMenuGroup
		,	@oIsUsed	= cIsUsed
		,	@oOrderBy	= cOrderBy
		,	@oNoteText	= cNoteText
	from	dbo.KWT001_SG_WS_MENU_LIST with(nolock)
	where	cMenuNo		= @pMenuNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(30)
,@o2 varchar(120)
,@o3 int
,@o4 bit
,@o5 int
,@o6 varchar(100)
,@sp int
exec dbo.KWP00104_SG_WS_MENU_INFO_R
 @pMenuNo = 100100001
,@oMenuName = @o1 output
,@oMenuUrl = @o2 output
,@oMenuGroup = @o3 output
,@oIsUsed = @o4 output
,@oOrderBy = @o5 output
,@oNoteText = @o6 output
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

grant execute on dbo.KWP00104_SG_WS_MENU_INFO_R to [opwebuser]
go

