use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_MENU_INFO_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_MENU_INFO_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_MENU_INFO_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_MENU_INFO_C
	Description	: 신규 메뉴 등록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_MENU_INFO_C
(	@pMenuName		nvarchar(20)
,	@pExecUrl		varchar(120)
,	@pMenuGroup		int
,	@pIsUsed		bit
,	@pIsView		bit
,	@pNoteText		nvarchar(50)
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if exists (
		select	top 1 1
		from	dbo.KWT001_SG_WS_MENU_LIST
		where	cExecUrl = @pExecUrl
	)
	begin
		set @oReturnNo = -2
		return
	end


	-- 새로운 메뉴로 등록
	insert into dbo.KWT001_SG_WS_MENU_LIST
		(	cMenuGroup
		,	cMenuNo
		,	cMenuName
		,	cExecUrl
		,	cNoteText
		,	cIsUsed
		,	cIsView
		,	cOrderBy
		,	cHostIp
		,	cCreateTime
		)
	select	@pMenuGroup
		,	isnull(max(cMenuNo) + 1,(right(@pMenuGroup,4))*1000)
		,	@pMenuName
		,	@pExecUrl
		,	@pNoteText
		,	@pIsUsed
		,	@pIsView
		,	case right(@pExecUrl,3)
				when '000' then 0
				else isnull(max(cOrderBy),0) + 1
			end
		,	@pHostIp
		,	@vGetDate
	from	dbo.KWT001_SG_WS_MENU_LIST
	where	cMenuGroup = @pMenuGroup

	if @@rowcount = 0
	begin
		set @oReturnNo = -3
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(20)
,@o2 varchar(120)
,@o3 int
,@o4 bit
,@o5 int
,@o6 varchar(100)
,@sp int
exec dbo.KWP00105_SG_WS_MENU_INFO_C
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

grant execute on dbo.KWP00105_SG_WS_MENU_INFO_C to [opwebuser]
go

