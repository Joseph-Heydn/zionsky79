use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_MENU_AUTH_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_MENU_AUTH_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_MENU_AUTH_LIST_R
go
/******************************************************************************
	Name		: dbo.KWP00102_SG_WS_MENU_AUTH_LIST_R
	Description	: 그룹에 등록된 메뉴를 조회한다.
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_MENU_AUTH_LIST_R
(	@pType		tinyint
,	@pSite		smallint
,	@pLangNo	tinyint
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if @pType = 0
	begin
		select	a.cSiteGroup
			,	a.cCommGroup as cMenuGroup
			,	b.cMenuNo
			,	case charindex('=',b.cExecUrl)
					when 0 then 0
					else substring(b.cExecUrl,charindex('=',b.cExecUrl)+1,7)
				end as cAuthNo
			,	isnull(c.cMenuName,b.cMenuName) as cMenuName
			,	b.cExecUrl
			,	isnull(b.cImageUrl,'') as cImageUrl
			,	b.cIsUsed
			,	b.cIsView
			,	b.cStep
			,	a.cOrderBy as cOrderBy1
			,	b.cOrderBy as cOrderBy2
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST	as a	-- 대 메뉴 그룹
				inner join
				dbo.KWT001_SG_WS_MENU_LIST		as b	-- 메뉴 트리
			on	b.cMenuGroup	= a.cCommGroup
				left outer join
				dbo.KWT001_SG_WS_MENU_NAME		as c	-- 메뉴 이름
			on	c.cMenuNo		= b.cMenuNo
			and	c.cLangNo		= @pLangNo
		where	b.cIsUsed		= 1
			and	a.cSiteGroup	= @pSite
	end
	else if @pType = 1
	begin
		select	cAuthGroup
			,	cMenuNo
			,	cIsRead
			,	cIsWrite
		from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE
		where	cSiteGroup = @pSite
	end


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_MENU_AUTH_LIST_R
 @pType = 0
,@pSite = 1001
,@pLangNo = 1
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.KWP00102_SG_WS_MENU_AUTH_LIST_R to [opwebuser]
go

