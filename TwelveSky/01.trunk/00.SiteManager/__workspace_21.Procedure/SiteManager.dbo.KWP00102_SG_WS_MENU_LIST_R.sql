use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_MENU_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_MENU_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_MENU_LIST_R
go
/******************************************************************************
	Name		: dbo.KWP00102_SG_WS_MENU_LIST_R
	Description	: 관리자 메뉴 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_MENU_LIST_R
(	@pSiteGroup		int
,	@pMenuGroup		int
,	@pLangNo		tinyint
,	@pFilterNo		tinyint
,	@pFilterText	nvarchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if @pMenuGroup = 0 and @pFilterNo = 0
	begin
		select	row_number() over(partition by b.cMenuGroup order by b.cOrderBy) as cGroup
			,	b.cMenuNo
			,	b.cMenuGroup
			,	a.cCommName as cGroupName
			,	isnull(c.cMenuName,b.cMenuName) as cMenuName
			,	b.cExecUrl
			,	b.cNoteText
			,	b.cIsUsed
			,	b.cIsView
			,	b.cOrderBy
			,	a.cCommGroup
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST	as a
				inner join
				dbo.KWT001_SG_WS_MENU_LIST		as b
			on	b.cMenuGroup	= a.cCommGroup
				left outer join
				dbo.KWT001_SG_WS_MENU_NAME		as c
			on	c.cMenuNo		= b.cMenuNo
			and	c.cLangNo		= @pLangNo
		where	a.cSiteGroup	= @pSiteGroup

		set @oReturnNo = 0
		return
	end


	if @pFilterNo = 0 and @pMenuGroup > 0
	begin
		select	row_number() over(partition by b.cMenuGroup order by b.cOrderBy) as cGroup
			,	b.cMenuNo
			,	b.cMenuGroup
			,	a.cCommName as cGroupName
			,	isnull(c.cMenuName,b.cMenuName) as cMenuName
			,	b.cExecUrl
			,	b.cNoteText
			,	b.cIsUsed
			,	b.cIsView
			,	b.cOrderBy
			,	a.cCommGroup
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST	as a
				inner join
				dbo.KWT001_SG_WS_MENU_LIST		as b
			on	b.cMenuGroup	= a.cCommGroup
				left outer join
				dbo.KWT001_SG_WS_MENU_NAME		as c
			on	c.cMenuNo		= b.cMenuNo
			and	c.cLangNo		= @pLangNo
		where	a.cSiteGroup	= @pSiteGroup
			and	a.cCommGroup	= @pMenuGroup

		set @oReturnNo = 0
		return
	end


	set @pFilterText = nullif(@pFilterText,'')
	if @pFilterText is null set @pFilterNo = 0

	select	row_number() over(partition by b.cMenuGroup order by b.cOrderBy) as cGroup
		,	b.cMenuNo
		,	b.cMenuGroup
		,	a.cCommName as cGroupName
		,	isnull(c.cMenuName,b.cMenuName) as cMenuName
		,	b.cExecUrl
		,	b.cNoteText
		,	b.cIsUsed
		,	b.cIsView
		,	b.cOrderBy
		,	a.cCommGroup
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST	as a
			inner join
			dbo.KWT001_SG_WS_MENU_LIST		as b
		on	b.cMenuGroup	= a.cCommGroup
			left outer join
			dbo.KWT001_SG_WS_MENU_NAME		as c
		on	c.cMenuNo		= b.cMenuNo
		and	c.cLangNo		= @pLangNo
	where	a.cSiteGroup	= @pSiteGroup
		and	(a.cCommGroup	= @pMenuGroup or @pMenuGroup = 0)
		and	b.cMenuNo		= case @pFilterNo when 1 then @pFilterText else b.cMenuNo end
		and	b.cMenuName		= case @pFilterNo when 2 then @pFilterText else b.cMenuName end


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_MENU_LIST_R
 @pSiteGroup = 1001
,@pMenuGroup = 0
,@pLangNo = 1
,@pFilterNo = 1
,@pFilterText = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00102_SG_WS_MENU_LIST_R to [opwebuser]
go

