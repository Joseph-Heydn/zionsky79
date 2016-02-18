use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_GRP_AUTH_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_GRP_AUTH_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_GRP_AUTH_LIST_R
go
/******************************************************************************
	name		: KWP00102_SG_WS_GRP_AUTH_LIST_R
	description	: 관리자 메뉴 권한 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_GRP_AUTH_LIST_R
(	@pSiteGroup		int
,	@pCommGroup		int
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	-- 비 구성원 목록 (어느 그룹에도 소속되지 않은 유저)
	select 	a.cAdminNo
		,	a.cAdminId
		,	a.cAdminName
		,	b.cCommName
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST as b
		on	b.cCommGroup	= a.cDeptNo
		and	b.cSiteGroup	= 3001		-- 부서
			left outer join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as c
		on	c.cAdminNo		= a.cAdminNo
	where	c.cAdminNo		is null


	-- 구성원 목록
	select 	a.cAdminNo
		,	b.cAdminId
		,	b.cAdminName
		,	c.cCommName
	from 	dbo.KWT001_SG_WS_MANGR_GROUP_MST as a
			inner join
			dbo.KWT001_SG_WS_MANGR_LIST as b
		on	b.cAdminNo		= a.cAdminNo
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST as c
		on	c.cCommGroup	= b.cDeptNo
		and	c.cSiteGroup	= 3001
	where	a.cAuthGroup	= @pCommGroup
	order by b.cAdminName



/*	-- 미 등록 그룹
	select	distinct
			a.cCommGroup
		,	a.cCommName
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			left outer join
			dbo.KWT001_SG_WS_MENU_GROUP_ROLE as b
		on	b.cMenuGroup	= a.cCommGroup
		and	b.cAuthGroup	= @pCommGroup
	where	a.cSiteGroup	= 1001
		and	b.cMenuGroup	is null
	order by a.cCommGroup


	-- 등록 그룹
	select	distinct
			a.cMenuGroup
		,	b.cCommName
	from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE as a
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST as b
		on	b.cCommGroup	= a.cMenuGroup
	where	a.cAuthGroup	= @pCommGroup
	order by a.cMenuGroup
*/


	-- 미 등록 메뉴
	select	a.cMenuGroup
		,	b.cCommName
		,	a.cMenuNo
		,	a.cMenuName
	from	dbo.KWT001_SG_WS_MENU_LIST as a
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST as b
		on	b.cCommGroup	= a.cMenuGroup
		and	b.cSiteGroup	= @pSiteGroup
			left outer join
			dbo.KWT001_SG_WS_MENU_GROUP_ROLE as c
		on	c.cMenuNo		= a.cMenuNo
		and	c.cAuthGroup	= @pCommGroup
	where	c.cMenuNo		is null


	-- 등록 메뉴
	select	a.cMenuNo
		,	c.cCommName
		,	b.cMenuName
		,	a.cIsWrite
	from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE as a
			inner join
			dbo.KWT001_SG_WS_MENU_LIST as b
		on	b.cMenuNo		= a.cMenuNo
		and	b.cMenuGroup	= a.cMenuGroup
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST as c
		on	c.cCommGroup	= a.cMenuGroup
	where	a.cAuthGroup	= @pCommGroup
		and	c.cSiteGroup	= @pSiteGroup


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_GRP_AUTH_LIST_R
 @pSiteGroup = 100200004
,@pCommGroup = 100200004
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00102_SG_WS_GRP_AUTH_LIST_R to [opwebuser]
go

