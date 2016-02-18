use SiteManager
go
if object_id('dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R') is null
	exec ('create procedure dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R as select 1')
--	drop procedure dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R
go
/******************************************************************************
	Name		: dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R
	Description	: 권한 그룹 드롭다운 리스트
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-12	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R
(	@pAdminNo	int
,	@pMode		tinyint
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vOrderBy int
	set @oReturnNo = -1

	select	@vOrderBy		= a.cOrderBy
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			inner join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as b
		on	b.cAuthGroup	= a.cCommGroup
	where	b.cAdminNo		= @pAdminNo

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	select	cCommGroup	as cAuthGroup
		,	cCommName	as cAuthName
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup	= 2001
		and	cOrderBy	>= @vOrderBy
		and cIsUsed		= 1
	order by cOrderBy


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R
@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00101_SG_WS_GRP_AUTH_DRPDN_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R') is null
	exec ('create procedure dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R as select 1')
--	drop procedure dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R
go
/******************************************************************************
	Name		: KWP00101_SG_WS_GRP_DEPT_DRPDN_R
	Description	: 부서 그룹 드롭다운 리스트
	Reference	:
	Result		: @oReturnNo
					 0	: Success
					-1	: initialize error

  Ver		Date		Author			Description
  --------	----------	--------------	------------------------------------
	1.0		2012-03-11	Hoon-Sik,Jin	1.초기생성
 ******************************************************************************/
alter procedure dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	-- 부서 그룹
	select	cCommGroup	as cDeptNo
		,	cCommName	as cDeptName
		,	cOrderBy
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
	where	cSiteGroup	= 3001
		and cIsUsed		= 1
	order by cOrderBy


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
exec dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R
@oReturnNo = 1
*/
go

grant execute on dbo.KWP00101_SG_WS_GRP_DEPT_DRPDN_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R') is null
	exec ('create procedure dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R as select 1')
--	drop procedure dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R
go
/******************************************************************************
	Name		: KWP00101_SG_WS_GRP_MENU_DRPDN_R
	Description	: 메뉴 그룹 드롭다운 리스트
	Reference	:
	Result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2012-03-11	Hoon-Sik,Jin	1.초기생성
 ******************************************************************************/
alter procedure dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R
(	@pSiteGroup		int
,	@pMode			tinyint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	if @pMode = 1
	begin
		select	cSiteGroup
			,	cSiteName
		from	dbo.KWT001_SG_WS_SITE_GROUP_MST
		where 	cSiteGroup	< 2001
			and	cIsUsed		= 1
		order by cSiteGroup
	end

	else
	begin
		select	cCommGroup	as cMenuGroup
			,	cCommName	as cGroupName
			,	cOrderBy
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST
		where 	cSiteGroup	= @pSiteGroup
			and	cIsUsed		= 1
		order by cOrderBy
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
exec dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R
 @pSiteGroup = 1001
,@pMode = 1
,@oReturnNo = 1
*/
go

grant execute on dbo.KWP00101_SG_WS_GRP_MENU_DRPDN_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_ADMIN_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_ADMIN_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_ADMIN_LIST_R
go
/******************************************************************************
	Name		: dbo.KWP00102_SG_WS_ADMIN_LIST_R
	Description	: 관리자 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_ADMIN_LIST_R
(	@pAuthGroup		int
,	@pCommGroup		int
,	@pAdminNo		int
,	@pFilterNo		tinyint
,	@pFilterText	nvarchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vAutherNo	int
		,	@vOrderBy	int
	set @oReturnNo = -1

	select	@vOrderBy		= b.cOrderBy
	from	dbo.KWT001_SG_WS_MANGR_GROUP_MST as a
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST	as b
		on	b.cCommGroup	= a.cAuthGroup
		and	b.cSiteGroup	= 2001
	where	a.cAdminNo		= @pAdminNo

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	if @pCommGroup = 0 and @pFilterText = ''
	begin
		select	a.cAdminNo
			,	a.cAdminId
			,	a.cAdminName
			,	a.cDeptNo
			,	c.cAuthGroup
			,	b.cCommName as cDeptName
			,	d.cCommName as cAuthName
			,	d.cOrderBy
			,	a.cIsUsed
			,	a.cNoteText
		from	dbo.KWT001_SG_WS_MANGR_LIST as a
				inner join
				dbo.KWT001_SG_WS_COMM_GROUP_MST as b
			on	b.cCommGroup	= a.cDeptNo
				inner join
				dbo.KWT001_SG_WS_MANGR_GROUP_MST as c
			on	c.cAdminNo		= a.cAdminNo
				inner join
				dbo.KWT001_SG_WS_COMM_GROUP_MST as d
			on	d.cCommGroup	= c.cAuthGroup
		where	(	c.cAuthGroup	= @pAuthGroup
				or	@pAuthGroup		= 0
				)
			and	(	d.cOrderBy		>= @vOrderBy
				or	d.cOrderBy		is null
				)
		union all
		select	a.cAdminNo
			,	a.cAdminId
			,	a.cAdminName
			,	0
			,	0
			,	''
			,	''
			,	-1
			,	a.cIsUsed
			,	a.cNoteText
		from	dbo.KWT001_SG_WS_MANGR_LIST as a
				left outer join
				dbo.KWT001_SG_WS_MANGR_GROUP_MST as b
			on	b.cAdminNo	= a.cAdminNo
		where	b.cAdminNo	is null


		set @oReturnNo = 0
		return
	end


	select	a.cAdminNo
		,	a.cAdminId
		,	a.cAdminName
		,	a.cDeptNo
		,	c.cAuthGroup
		,	b.cCommName as cDeptName
		,	d.cCommName as cAuthName
		,	d.cOrderBy
		,	a.cIsUsed
		,	a.cNoteText
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST	as b
		on	b.cCommGroup	= a.cDeptNo
		and	b.cSiteGroup	= 3001
			inner join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as c
		on	c.cAdminNo		= a.cAdminNo
		and	c.cAuthGroup	> 0
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST	as d
		on	d.cCommGroup	= c.cAuthGroup
	where	(	d.cOrderBy	>= @vOrderBy
			or	d.cOrderBy	is null
			)
		and	a.cAdminName	> ''
		and	a.cAdminNo		> 0
		and	(	d.cCommGroup	= @pCommGroup
			or	@pCommGroup		= 0
			)
		and	(	c.cAuthGroup	= @pAuthGroup
			or	@pAuthGroup		= 0
			)
		and	a.cAdminNo		= case @pFilterNo when 3 then convert(int,@pFilterText) else a.cAdminNo end
		and	a.cAdminId		= case @pFilterNo when 2 then @pFilterText else a.cAdminId end
		and	a.cAdminName	= case @pFilterNo when 1 then @pFilterText else a.cAdminName end


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_ADMIN_LIST_R
 @pAuthGroup = 0
,@pCommGroup = 0
,@pAdminNo = 100000001
,@pFilterNo = 1
,@pFilterText = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00102_SG_WS_ADMIN_LIST_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_AUTH_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_AUTH_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_AUTH_LIST_R
go
/******************************************************************************
	name		: KWP00102_SG_WS_AUTH_LIST_R
	description	: 관리자 검색 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_AUTH_LIST_R
(	@pAdminNo		int
,	@pAdminId		varchar(20)
,	@pAdminName		nvarchar(20)
,	@pGroupNo		int
,	@oRowCnt		int		output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	a.cAdminNo
		,	a.cAdminId
		,	a.cAdminName
		,	a.cDeptNo
		,	a.cNoteText
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
			inner join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as b
		on	b.cAdminNo		= a.cAdminNo
	where	(a.cAdminNo		= @pAdminNo		or @pAdminNo = 0)
		and	(	a.cAdminName	> N''
			and	(a.cAdminId	= @pAdminId		or	@pAdminId = '')
			)
		and	(a.cAdminName	= @pAdminName	or @pAdminName = N'')
		and	(b.cAuthGroup	= @pGroupNo		or @pGroupNo = 0)
	order by a.cAdminName

	set @oRowCnt = @@rowcount


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare
 @P1 int
,@SP int
exec dbo.KWP00102_SG_WS_AUTH_LIST_R
 @pAdminNo = 0
,@pAdminId = 'likethis79'
,@pAdminName = ''
,@pGroupNo = ''
,@oRowCnt = @P1 output
,@oReturnNo = @SP output

print @P1
*/
go

grant execute on dbo.KWP00102_SG_WS_AUTH_LIST_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R
go
/******************************************************************************
	Name		: dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R
	Description	: 관리자 지급 기록 조회
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 날짜 변환 오류
					-3	: 입력값 오류
					-4	: 접속 로그 생성실패

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-04-21	Hong-Suk,Kim	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R
(	@pStartDate		int
,	@pFinishDate	int
,	@pPlayerNo		bigint
,	@pPublisher		tinyint
,	@pAdminNo		int
,	@pAction		tinyint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	--입력값 검증
	if @pStartDate < 20150501
	begin
		set @oReturnNo = -2
		return
	end

	if @pFinishDate < @pStartDate
	begin
		set @oReturnNo = -3
		return
	end


	select	a.cWorkDate
		,	a.cServerNo
		,	a.cPlayerNo
		,	a.cNickName
		,	a.cPublisher
		,	a.cMailNo
		,	a.cAction
		,	a.cValueNew
		,	a.cValueOld
		,	a.cTryCnt
		,	a.cAdminNo
		,	a.cHostIp
		,	a.cModifyTime
		,	a.cCreateTime
		,	b.cAdminId
	from	dbo.KWT002_SG_WS_GOODS_LOG	as a
			inner join
			dbo.KWT001_SG_WS_MANGR_LIST	as b
		on	a.cAdminNo	= b.cAdminNo
	where	a.cWorkDate		between @pStartDate and @pFinishDate
		and	(a.cAction		= @pAction	or @pAction = 0)
		and	(a.cAdminNo		= @pAdminNo	or @pAdminNo = 0)
/*		and	(a.cPlayerNo	= @pPlayerNo	or @pPlayerNo = 0)
		and	(a.cPublisher	= @pPublisher	or @pPublisher = 0)
		and	a.cAction		= case @pAction when 0 then a.cAction else @pAction end
		and	a.cAdminNo		= case @pAdminNo when 0 then a.cAdminNo else @pAdminNo end
		and	a.cPlayerNo		= case @pPlayerNo when 0 then a.cPlayerNo else @pPlayerNo end
		and	a.cPublisher	= case @pPublisher when 0 then a.cPublisher else @pPublisher end
*/
	if @@rowcount = 0
	begin
		set @oReturnNo = -4
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R
 @pStartDate = 20150522
,@pFinishDate = 20150522
,@pPlayerNo = 0
,@pPublisher = 0
,@pAdminNo = 0
,@pAction = 13
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00102_SG_WS_GOODS_LOG_LIST_R to [opwebuser]
go

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

use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_GRP_COMM_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_GRP_COMM_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_GRP_COMM_LIST_R
go
/******************************************************************************
	name		: KWP00102_SG_WS_GRP_COMM_LIST_R
	description	: 사이트 코드에 대한 그룹코드 리스트 반환
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_GRP_COMM_LIST_R
(	@pSiteGroup		smallint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cSiteGroup
		,	cCommGroup
		,	cCommName
		,	cNoteText
		,	cIsUsed
		,	cOrderBy
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
	where	cSiteGroup	= @pSiteGroup
--		and	cIsUsed	= 1
	order by cOrderBy


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @SP int
exec dbo.KWP00102_SG_WS_GRP_COMM_LIST_R
 @pSiteGroup = 10001
,@oReturnNo = @SP output

print @SP
*/
go

grant execute on dbo.KWP00102_SG_WS_GRP_COMM_LIST_R to [opwebuser]
go


use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_GRP_SITE_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_GRP_SITE_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_GRP_SITE_LIST_R
go
/******************************************************************************
	name		: KWP00102_SG_WS_GRP_SITE_LIST_R
	description	: 사이트 관리자 코드 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_GRP_SITE_LIST_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cSiteGroup
		,	cSiteName
		,	cNoteText
		,	cIsUsed
	from	dbo.KWT001_SG_WS_SITE_GROUP_MST with(nolock)
--	where	cIsUsed	= 1
	order by cSiteGroup


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @SP int
exec dbo.KWP00102_SG_WS_GRP_SITE_LIST_R
@oReturnNo = @SP output

print @SP
*/
go

grant execute on dbo.KWP00102_SG_WS_GRP_SITE_LIST_R to [opwebuser]
go


use SiteManager
go
if object_id('dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R') is null
	exec ('create procedure dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R as select 1')
--	drop procedure dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R
go
/******************************************************************************
	Name		: dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R
	Description	: 관리자 액션 기록 조회
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 날짜 변환 오류
					-3	: 입력값 오류
					-4	: 접속 로그 생성실패

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-04-02	Kim, Hongsuk	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R
(	@pStartDate		int
,	@pFinishDate	int
,	@pAdminNo		int
,	@pMenuNo		int
,	@oReturnNo		int		output

) as
begin
	set nocount ON
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	--입력값 검증
	if @pStartDate < 20150501
	begin
		set @oReturnNo = -3
		return
	end

	if @pFinishDate < @pStartDate
	begin
		set @oReturnNo = -3
		return
	end

	if @pMenuNo < -1
	begin
		set @oReturnNo = -3
		return
	end


	create table #tmpFilterManagerLogs
	(	cLogs bigint not null
	)

	if @pMenuNo > 0 and @pAdminNo > 0
	begin
		insert into #tmpFilterManagerLogs
		select	cLogs
		from	dbo.KWT001_SG_WS_MANGR_LOG
		where	cWorkDate	between @pStartDate and @pFinishDate
			and	cAdminNo	= @pAdminNo
			and	cMenuNo		= @pMenuNo
	end
	else if @pMenuNo > 0 and @pAdminNo = 0
	begin
		insert into #tmpFilterManagerLogs
		select	cLogs
		from	dbo.KWT001_SG_WS_MANGR_LOG
		where	cWorkDate	between @pStartDate and @pFinishDate
			and	cAdminNo	> 0
			and	cMenuNo		= @pMenuNo
	end
	else
	begin
		insert into #tmpFilterManagerLogs
		select	cLogs
		from	dbo.KWT001_SG_WS_MANGR_LOG
		where	cWorkDate	between @pStartDate and @pFinishDate
			and	cAdminNo	> 0
			and	cMenuNo		> 0
	end

	if @@rowcount = 0
	begin
		set @oReturnNo = -4
		return
	end


	select	a.cLogs
		,	a.cAdminNo
		,	b.cAdminId as cAdminId
		,	a.cMenuNo
		,	isnull(c.cMenuName,'login') as cMenuName
		,	a.cHttpGet
		,	a.cHttpPost
		,	a.cReferer
		,	a.cHostIp
		,	a.cCreateTime
	from	#tmpFilterManagerLogs as s
			inner join
			dbo.KWT001_SG_WS_MANGR_LOG as a
		on	a.cLogs		= s.cLogs
			left outer join
			dbo.KWT001_SG_WS_MANGR_LIST	as b
		on	b.cAdminNo	= a.cAdminNo
			left outer join
			dbo.KWT001_SG_WS_MENU_LIST as c
		on	c.cMenuNo	= a.cMenuNo

	if @@rowcount = 0
	begin
		set @oReturnNo = -5
		return
	end


	drop table #tmpFilterManagerLogs

	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R
 @pStartDate = 20150623
,@pFinishDate = 20150629
,@pAdminNo = 100000001
,@pMenuNo = 1009002
,@oReturnNo = @sp output

print @sp
set statistics io off
*/
go

grant execute on dbo.KWP00102_SG_WS_MANGR_LOG_LIST_R to [opwebuser]
go

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
		select	row_number() over(partition by b.cMenuGroup order by b.cOrderBy) as cSeqNo
			,	b.cMenuNo
			,	b.cMenuGroup
			,	a.cCommName as cGroupName
			,	b.cMenuName
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
		where	a.cSiteGroup	= @pSiteGroup

		set @oReturnNo = 0
		return
	end


	if @pFilterNo = 0 and @pMenuGroup > 0
	begin
		select	row_number() over(partition by b.cMenuGroup order by b.cOrderBy) as cSeqNo
			,	b.cMenuNo
			,	b.cMenuGroup
			,	a.cCommName as cGroupName
			,	b.cMenuName
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
		where	a.cSiteGroup	= @pSiteGroup
			and	a.cCommGroup	= @pMenuGroup

		set @oReturnNo = 0
		return
	end


	set @pFilterText = nullif(@pFilterText,'')
	if @pFilterText is null set @pFilterNo = 0

	select	row_number() over(partition by b.cMenuGroup order by b.cOrderBy) as cSeqNo
		,	b.cMenuNo
		,	b.cMenuGroup
		,	a.cCommName as cGroupName
		,	b.cMenuName
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
,@pFilterNo = 1
,@pFilterText = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00102_SG_WS_MENU_LIST_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00103_SG_WS_ADMIN_LOGIN_R') is null
	exec ('create procedure dbo.KWP00103_SG_WS_ADMIN_LOGIN_R as select 1')
--	drop procedure dbo.KWP00103_SG_WS_ADMIN_LOGIN_R
go
/******************************************************************************
	Name		: dbo.KWP00103_SG_WS_ADMIN_LOGIN_R
	Description	: 관리자 로그인
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 사용자 정보 불일치
					-3	: 접속 로그 생성실패
					-4	: 로그인 정보 불일치

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00103_SG_WS_ADMIN_LOGIN_R
(	@pAdminId		varchar(20)
,	@pPassword		char(32)
,	@oAdminNo		int				output
,	@oAdminName		nvarchar(20)	output
,	@oAuthGroup		int				output
,	@oDeptNo		int				output
,	@oConnTime		datetime		output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	--입력값 검증
	if len(@pAdminId) < 1 or len(@pPassword) < 1
	begin
		set @oReturnNo = -2
		return
	end


	select	@oAdminNo	= a.cAdminNo
		,	@oAdminName	= a.cAdminName
		,	@oDeptNo	= a.cDeptNo
		,	@oAuthGroup	= b.cAuthGroup
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
			inner join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST as b
		on	b.cAdminNo	= a.cAdminNo
	where	a.cAdminId	= @pAdminId
		and	a.cPassword	= @pPassword
		and	a.cIsUsed	= 1

	if @@rowcount = 1
	begin
		update	a
		set		@oConnTime	= cLoginTime = getdate()
		from	dbo.KWT001_SG_WS_MANGR_LIST as a
		where	cAdminId	= @pAdminId
			and	cPassword	= @pPassword

		if @@error != 0
		begin
			set @oReturnNo = -3
			return
		end
	end

	else
	begin
		--관리자 정보 불일치(ID/PWD 불일치)
		set @oReturnNo = -4
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @p3 int
,@p4 varchar(20)
,@p5 int
,@p6 int
,@p7 datetime
,@sp int
exec dbo.KWP00103_SG_WS_ADMIN_LOGIN_R
 @pAdminId = 'msu0308'
,@pPassword = '23bded6516f0fde8fa6c057983e2a1c7'
,@oAdminNo = @p3 output
,@oAdminName = @p4 output
,@oAuthGroup = @p5 output
,@oDeptNo = @p6 output
,@oConnTime = @p7 output
,@oReturnNo = @sp output

print @p3
print @p4
print @p5
print @p6
print @p7
print @sp
*/
go

grant execute on dbo.KWP00103_SG_WS_ADMIN_LOGIN_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R') is null
	exec ('create procedure dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R as select 1')
--	drop procedure dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R
go
/******************************************************************************
	Name		: dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R
	Description	: 접근하는 페이지가 존재하는지, 권한이 있는지 확인
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-12	Hoon-Sik,Jin	1.CREATE
 *******************************************************************************/
alter procedure dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R
(	@pAuthGroup		int
,	@pMenuNo		int
,	@oMenuGroup		int				output
,	@oGroupName		nvarchar(20)	output
,	@oMenuName		nvarchar(20)	output
,	@oExecUrl		varchar(120)	output
,	@oNoteText		nvarchar(50)	output
,	@oIsUsed		bit				output
,	@oIsRead		bit				output
,	@oIsWrite		bit				output
,	@oReturnNo		int 			output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oMenuName	= ''
		,	@oGroupName	= ''
		,	@oIsUsed	= ''
		,	@oExecUrl	= ''
		,	@oNoteText	= ''
		,	@oMenuGroup	= 0
		,	@oIsUsed	= 0
		,	@oIsRead	= 0
		,	@oIsWrite	= 0
		,	@oReturnNo	= -1

	select	@oMenuName		= b.cMenuName
		,	@oMenuGroup		= b.cMenuGroup
		,	@oGroupName		= c.cCommName
		,	@oIsUsed		= b.cIsUsed
		,	@oExecUrl		= b.cExecUrl
		,	@oNoteText		= b.cNoteText
		,	@oIsUsed		= b.cIsUsed
		,	@oIsRead		= a.cIsRead
		,	@oIsWrite		= a.cIsWrite
	from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE as a
			inner join
			dbo.KWT001_SG_WS_MENU_LIST as b
		on	b.cMenuNo		= a.cMenuNo
		and	b.cMenuGroup	= a.cMenuGroup
			inner join
			dbo.KWT001_SG_WS_COMM_GROUP_MST as c
		on	c.cCommGroup	= b.cMenuGroup
		and	c.cSiteGroup	> 0
	where	a.cAuthGroup	= @pAuthGroup
		and	a.cMenuNo		= @pMenuNo

	if @@rowcount != 1
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare
 @o1 nvarchar(20)
,@o2 int
,@o3 nvarchar(20)
,@o4 varchar(120)
,@o5 nvarchar(100)
,@o6 bit
,@o7 bit
,@o8 bit
,@sp int
exec dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R
 @pAuthGroup = 2001002
,@pMenuNo = 1001000
,@oMenuName = @o1 out
,@oMenuGroup = @o2 out
,@oGroupName = @o3 out
,@oExecUrl = @o4 out
,@oNoteText = @o5 out
,@oIsUsed = @o6 out
,@oIsRead = @o7 out
,@oIsWrite = @o8 out
,@oReturnNo = @sp output

print  '@oMenuName	: '+ rtrim(@o1)
print  '@oMenuGroup	: '+ rtrim(@o2)
print  '@oGroupName	: '+ rtrim(@o3)
print  '@oExecUrl	: '+ rtrim(@o4)
print  '@oNoteText	: '+ rtrim(@o5)
print  '@oIsUsed	: '+ rtrim(@o6)
print  '@oIsRead	: '+ rtrim(@o7)
print  '@oIsWrite	: '+ rtrim(@o8)
print  '@oReturnNo	: '+ rtrim(@sp)
*/
go

grant execute on dbo.KWP00103_SG_WS_MENU_GRP_ROLE_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00103_SG_WS_MENU_NO_R') is null
	exec ('create procedure dbo.KWP00103_SG_WS_MENU_NO_R as select 1')
--	drop procedure dbo.KWP00103_SG_WS_MENU_NO_R
go
/******************************************************************************
	name		: KWP00103_SG_WS_MENU_NO_R
	description	: 관리자페이지 -> 매뉴 코드 읽어오기
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00103_SG_WS_MENU_NO_R
(	@pExecUrl	varchar(120)
,	@oMenuNo	int		output
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oMenuNo	= 0
		,	@oReturnNo	= -1

	if len(@pExecUrl) = 0
	begin
		set @oReturnNo = -1
		return
	end


	select 	@oMenuNo	= cMenuNo
	from	dbo.KWT001_SG_WS_MENU_LIST
	where	cExecUrl	= @pExecUrl
		and	cIsUsed		= 1

	if @@rowcount != 1
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 int
,@SP int
exec dbo.KWP00103_SG_WS_MENU_NO_R
 @pExecUrl = '/APP/SiteManager/siteBaseCode.aspx'
,@oMenuNo = @o1 output
,@oReturnNo = @SP output

print @o1
print @SP
*/
go

grant execute on dbo.KWP00103_SG_WS_MENU_NO_R to [opwebuser]
go


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

use SiteManager
go
if object_id('dbo.KWP00104_SG_WS_GRP_COMM_INFO_R') is null
	exec ('create procedure dbo.KWP00104_SG_WS_GRP_COMM_INFO_R as select 1')
--	drop procedure dbo.KWP00104_SG_WS_GRP_COMM_INFO_R
go
/******************************************************************************
	Name		: dbo.KWP00104_SG_WS_GRP_COMM_INFO_R
	Description	: 공통 그룹 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00104_SG_WS_GRP_COMM_INFO_R
(	@pCommGroup		int
,	@oCommName		nvarchar(20)	output
,	@oNoteText		nvarchar(50)	output
,	@oIsUsed		bit				output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	@oCommName	= cCommName
		,	@oNoteText	= cNoteText
		,	@oIsUsed	= cIsUsed
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
	where	cCommGroup	= @pCommGroup


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(100)
,@o2 varchar(150)
,@o3 int
,@sp int
exec dbo.KWP00104_SG_WS_GRP_COMM_INFO_R
 @pCommGroup = 100100001
,@oCommName = @o1 output
,@oNoteText = @o2 output
,@oIsUsed = @o3 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @sp
*/
go

grant execute on dbo.KWP00104_SG_WS_GRP_COMM_INFO_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00104_SG_WS_GRP_SITE_INFO_R') is null
	exec ('create procedure dbo.KWP00104_SG_WS_GRP_SITE_INFO_R as select 1')
--	drop procedure dbo.KWP00104_SG_WS_GRP_SITE_INFO_R
go
/******************************************************************************
	Name		: dbo.KWP00104_SG_WS_GRP_SITE_INFO_R
	Description	: 사이트 그룹 정보
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00104_SG_WS_GRP_SITE_INFO_R
(	@pSiteGroup		int
,	@oSiteName		nvarchar(20)	output
,	@oNoteText		nvarchar(50)	output
,	@oIsUsed		bit				output
,	@oGroupCnt		int				output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oSiteName	= cSiteName
		,	@oNoteText	= cNoteText
		,	@oIsUsed	= cIsUsed
	from	dbo.KWT001_SG_WS_SITE_GROUP_MST
	where	cSiteGroup	= @pSiteGroup

	select	@oGroupCnt	= count(*)
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup	= @pSiteGroup


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(100)
,@o2 varchar(150)
,@o3 int
,@o4 int
,@sp int
exec dbo.KWP00104_SG_WS_GRP_SITE_INFO_R
 @pSiteGroup = 10001
,@oSiteName = @o1 output
,@oNoteText = @o2 output
,@oIsUsed = @o3 output
,@oCommGroupCnt = @o4 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @sp
*/
go

grant execute on dbo.KWP00104_SG_WS_GRP_SITE_INFO_R to [opwebuser]
go

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

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_ACTION_LOG_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_ACTION_LOG_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_ACTION_LOG_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_ACTION_LOG_C
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
alter procedure dbo.KWP00105_SG_WS_ACTION_LOG_C
(	@pGameNo		int
,	@pAccountNo		int
,	@pMenuNo		int
,	@pProcedure		varchar(80)
,	@pResult		int
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_ACTION_LOG
		(	cWorkDate
		,	cGameNo
		,	cAccountNo
		,	cMenuNo
		,	cProcedure
		,	cResult
		,	cHostIp
		,	cCreateTime
		)
	values
		(	convert(char(8),@vGetDate,112)
		,	@pGameNo
		,	@pAccountNo
		,	@pMenuNo
		,	@pProcedure
		,	@pResult
		,	@pHostIp
		,	@vGetDate
		)

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00105_SG_WS_ACTION_LOG_C
 @pGameNo = 20150001
,@pAccountNo = 100000001
,@pMenuNo = 1009002
,@pProcedure = 'KWP00105_SG_WS_ADMIN_LOG_C'
,@pResult = 0
,@pHostIp = '127.0.0.1'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_ACTION_LOG_C to [opwebuser]
go

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

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_ADMIN_INFO_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_ADMIN_INFO_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_ADMIN_INFO_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_ADMIN_INFO_C
	Description	: 관리 유저 추가
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: password error
					-3	: duplicate id
					-4	: duplicate name
					-5	: INSERT error
					-6	: SELECT error
					-7	: delete error
					-8	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-07-03	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_ADMIN_INFO_C
(	@pAdminId		varchar(20)
,	@pPassword		char(32)
,	@pAdminName		nvarchar(20)
,	@pAuthGroup		int
,	@pDeptNo		int
,	@pIsUsed		bit
,	@pNoteText		nvarchar(30)
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vAdminNo int
		,	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if len(@pPassword) < 32
	begin
		set @oReturnNo = -2
		return
	end

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_MANGR_LIST
		where	cAdminId = @pAdminId
	)
	begin
		set @oReturnNo = -3
		return
	end

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_MANGR_LIST
		where	cAdminName = @pAdminName
	)
	begin
		set @oReturnNo = -4
		return
	end


	begin tran
		select	@vAdminNo	= next value for dbo.sAdminNo
			,	@oReturnNo	= -5

		-- 새로운 메뉴로 등록
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
			(	@vAdminNo
			,	@pAdminId
			,	@pPassword
			,	@pAdminName
			,	@pDeptNo
			,	@pIsUsed
			,	@pNoteText
			,	@pHostIp
			,	@vGetDate
			)

		if @@rowcount = 0
		begin
			if @@trancount > 0 rollback tran
			return
		end


		set @oReturnNo = -6
		-- 기존 권한 삭제
		delete
		from	dbo.KWT001_SG_WS_MANGR_GROUP_MST
		where	cAdminNo = @vAdminNo

		if @@rowcount > 1
		begin
			if @@trancount > 0 rollback tran
			return
		end


		set @oReturnNo = -7
		-- 권한 부여
		insert into dbo.KWT001_SG_WS_MANGR_GROUP_MST
			(	cAuthGroup
			,	cAdminNo
			,	cCreateTime
			)
		values
			(	@pAuthGroup
			,	@vAdminNo
			,	@vGetDate
			)

		if @@rowcount = 0
		begin
			if @@trancount > 0 rollback tran
			return
		end
	commit tran


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @rt int
exec dbo.KWP00105_SG_WS_ADMIN_INFO_C
 @pAdminId = 'likethis79'
,@pPassword = 'efb50b1cf32d8db47ff91573d64f1984'
,@pAdminName = N'진훈식'
,@pDeptGroup = 3001001
,@pIsUsed = 1
,@pNoteText = N'최고관리자 입니다!!'
,@pHostIp = '221.140.152.71'
,@oReturnNo = @rt output

print @rt
*/
go

grant execute on dbo.KWP00105_SG_WS_ADMIN_INFO_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_ADMIN_LOG_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_ADMIN_LOG_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_ADMIN_LOG_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_ADMIN_LOG_C
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
alter procedure dbo.KWP00105_SG_WS_ADMIN_LOG_C
(	@pGameNo	int
,	@pAdminNo	int
,	@pMenuNo	int
,	@pHttpGet	nvarchar(max)
,	@pHttpPost	nvarchar(max)
,	@pReferer	nvarchar(max)
,	@pHostIp	varchar(15)
,	@oReturnNo	int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_MANGR_LOG
		(	cWorkDate
		,	cGameNo
		,	cAdminNo
		,	cMenuNo
		,	cHttpGet
		,	cHttpPost
		,	cReferer
		,	cHostIp
		,	cCreateTime
		)
	values
		(	convert(char(8),@vGetDate,112)
		,	@pGameNo
		,	@pAdminNo
		,	@pMenuNo
		,	nullif(@pHttpGet,'')
		,	nullif(@pHttpPost,'')
		,	nullif(@pReferer,'')
		,	@pHostIp
		,	@vGetDate
		)

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00105_SG_WS_ADMIN_LOG_C
 @pGameNo = 20150001
,@pAdminNo = 100000001
,@pMenuNo = 1009002
,@pHttpGet = 'pLargePart=0&pMainFlag=False&pGameNo=20150001&pBoardNo=1000007&pBoardType=1&pPageNo=2&pIsNext=0&pJumpSize=1&pRowCnt=76&pLastNo=4016&pLastVo=0&pLimitDate=2015-05-04&pFilterKey=3&pListCnt=20&pDeleted=false&pNotice=false'
,@pHttpPost = 'drpLargePart=0&txtGameNo=20150001&txtMenuNo=1000007&txtWriteNo=3992&txtIsNew=1&txtMenuType=1&txtRows=13&txtLimitDate=2015-05-04&drpFilterKey=3&drpCategory=1&drpPageSize=20&drpMenuList=1000013'
,@pReferer = 'http://www.adminsite.dev/board/manage.aspx?pLargePart=0&pMainFlag=False&pGameNo=20150001&pBoardNo=1000007&pBoardType=1&pPageNo=2&pIsNext=0&pJumpSize=1&pRowCnt=76&pLastNo=4016&pLastVo=0&pLimitDate=2015-05-04&pFilterKey=3&pFilterText=&pListCnt=20&pDeleted=false&pNotice=false'
,@pHostIp = '127.0.0.1'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_ADMIN_LOG_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C
go
/******************************************************************************
	name		: KWP00105_SG_WS_GRP_AUTH_INFO_C
	description	: 권한 그룹 생성하기
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: duplicate group name
					-3	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C
(	@pSiteGroup		smallint
,	@pCommName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pHostIp		varchar(15)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST
		where	cSiteGroup	= @pSiteGroup
			and	cCommName	= @pCommName
	)
	begin
		set @oReturnNo = -2
		return
	end


	-- 그룹 기본정보
	insert into dbo.KWT001_SG_WS_COMM_GROUP_MST
		(	cSiteGroup
		,	cCommGroup
		,	cCommName
		,	cOrderBy
		,	cNoteText
		,	cIsUsed
		,	cHostIp
		,	cCreateTime
		)
	select	@pSiteGroup
		,	max(cCommGroup) + 1
		,	@pCommName
		,	max(cOrderBy) + 1
		,	@pNoteText
		,	@pIsUsed
		,	@pHostIp
		,	@vGetDate
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup = @pSiteGroup

	if @@rowcount != 1
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
 @o1 int
,@o2 varchar(100)
,@o3 bit
,@o4 varchar(150)
,@sp int
exec dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C
 @pCommGroup = 100200004
,@o_cAuthGroup = @o1 output
,@o_cAuthName = @o2 output
,@oIsUsed = @o3 output
,@oNoteText = @o4 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_USER_AUTH_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_USER_AUTH_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_USER_AUTH_C
go
/******************************************************************************
	name		: KWP00105_SG_WS_GRP_USER_AUTH_C
	description	: 관리자 메뉴 권한 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_USER_AUTH_C
(	@pAuthGroup		int
,	@pAdminList		varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_MANGR_GROUP_MST
		(	cAuthGroup
		,	cAdminNo
		,	cCreateTime
		)
	select	@pAuthGroup
		,	a.cValue
		,	@vGetDate
	from	dbo.fnTbl2Int(@pAdminList,'|')	as a
			left outer join
			dbo.KWT001_SG_WS_MANGR_GROUP_MST	as b with(nolock)
		on	b.cAdminNo		= a.cValue
		and	b.cAuthGroup	= @pAuthGroup
	where	b.cAdminNo		is null

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00105_SG_WS_GRP_USER_AUTH_C
 @pAuthGroup = 100200003
,@pAdminList = '|'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_GRP_USER_AUTH_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_COMM_INFO_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_COMM_INFO_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_COMM_INFO_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_GRP_COMM_INFO_C
	Description	: 관리자 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					 1	: 파라미터 값 오류
					-1	: initialize error
					-2	: UPDATE error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_COMM_INFO_C
(	@pSiteGroup		int
,	@pCommName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pIsUsed		bit
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vMenuGroup int
		,	@vExecUrl	nvarchar(20)
		,	@vGetDate	datetime = getdate()
	set @oReturnNo = -1

	if @pCommName = '' or @pNoteText = ''
	begin
		set @oReturnNo = 1
		return
	end

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST
		where	cSiteGroup	= @pSiteGroup
			and	cCommName	= @pCommName
	)
	begin
		set @oReturnNo = 2
		return
	end


	insert into dbo.KWT001_SG_WS_COMM_GROUP_MST
		(	cSiteGroup
		,	cCommGroup
		,	cCommName
		,	cOrderBy
		,	cNoteText
		,	cIsUsed
		,	cHostIp
		,	cCreateTime
		)
	select	@pSiteGroup
		,	isnull(max(cCommGroup),(@pSiteGroup*1000)) + 1
		,	@pCommName
		,	isnull(max(cOrderBy),0) + 1
		,	@pNoteText
		,	@pIsUsed
		,	@pHostIp
		,	@vGetDate
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup = @pSiteGroup

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	select	top 1
			@vMenuGroup	= cCommGroup
		,	@vExecUrl	= '/App/'+ rtrim(cCommGroup)
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup	= @pSiteGroup
		and	cCommName	= @pCommName

	if not exists (
		select	top 1 1
		from	dbo.KWT001_SG_WS_MENU_LIST
		where	cMenuGroup = @vMenuGroup
			and	cMenuNo		= right(@pSiteGroup,5) * 1000
	)
	begin
		exec dbo.KWP00105_SG_WS_MENU_INFO_C
				@pMenuName		= @pCommName
			,	@pExecUrl		= @vExecUrl
			,	@pMenuGroup		= @vMenuGroup
			,	@pIsUsed		= 1
			,	@pIsView		= 1
			,	@pNoteText		= ''
			,	@pHostIp		= null
			,	@oReturnNo		= @oReturnNo output

		if @@error != 0 or @oReturnNo != 0
			return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(100)
,@o2 varchar(150)
,@o3 int
,@sp int
exec dbo.KWP00105_SG_WS_GRP_COMM_INFO_C
 @pCommGroup = 100100001
,@pCommName = ''
,@pNoteText = ''
,@pIsUsed = 1
,@pHostIp = ''
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_GRP_COMM_INFO_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C
go
/******************************************************************************
	name		: KWP00105_SG_WS_GRP_MENU_AUTH_C
	description	: 관리자 메뉴 권한 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C
(	@pAdminNo		int
,	@pAuthGroup		int
,	@pMenuList		varchar(4000)
,	@pWriteList		varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_MENU_GROUP_ROLE
		(	cAuthGroup
		,	cMenuGroup
		,	cMenuNo
		,	cIsRead
		,	cIsWrite
		,	cUpdaterNo
		,	cCreateTime
		)
	select	@pAuthGroup
		,	c.cMenuGroup
		,	c.cMenuNo
		,	1
		,	case when b.cValue is null then 0 else 1 end
		,	@pAdminNo
		,	@vGetDate
	from	dbo.fnTbl2Int(@pMenuList,'|') as a
			left outer join
			dbo.fnTbl2Int(@pWriteList,'|') as b
		on	a.cValue		= b.cValue
			inner join
			dbo.KWT001_SG_WS_MENU_LIST as c
		on	c.cMenuNo		= a.cValue
			left outer join
			dbo.KWT001_SG_WS_MENU_GROUP_ROLE as d
		on	d.cMenuNo		= a.cValue
		and	d.cAuthGroup	= @pAuthGroup
	where	d.cMenuNo		is null

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C
 @pAdminNo = 100000001
,@pAuthGroup = 100200005
,@pMenuList = '100100003|'
,@pWriteList = ''
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_GRP_MENU_AUTH_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_MENU_LIST_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_MENU_LIST_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_MENU_LIST_C
go
/******************************************************************************
	name		: KWP00105_SG_WS_GRP_MENU_LIST_C
	description	: 관리자 메뉴 권한 리스트
	reference	:
	result		: @o_return_no
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_MENU_LIST_C
(	@pAdminNo		int
,	@pAuthGroup		int
,	@pMenuList		varchar(4000)
,	@pWriteList		varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_MENU_GROUP_ROLE
		(	cAuthGroup
		,	cMenuGroup
		,	cMenuNo
		,	cIsRead
		,	cIsWrite
		,	cUpdaterNo
		,	cCreateTime
		)
	select	@pAuthGroup
		,	C.cMenuGroup
		,	C.cMenuNo
		,	1
		,	case when B.cValue is null then 0 else 1 end
		,	@pAdminNo
		,	@vGetDate
	from	dbo.fnTbl2Int(@pMenuList,'|') as A
			left outer join
			dbo.fnTbl2Int(@pWriteList,'|') as B
		on	A.cValue		= B.cValue
			inner join
			dbo.KWT001_SG_WS_MENU_LIST as C
		on	C.cMenuNo		= A.cValue
			left outer join
			dbo.KWT001_SG_WS_MENU_GROUP_ROLE as D
		on	D.cMenuNo		= A.cValue
		and	D.cAuthGroup	= @pAuthGroup
	where	D.cMenuNo		is null

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00105_SG_WS_GRP_MENU_LIST_C
 @i_admin_no = 100000001
,@i_auth_grp_no = 100200005
,@i_menu_list = '100100003|'
,@i_write_list = ''
,@o_return_no = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_GRP_MENU_LIST_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_SITE_INFO_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_SITE_INFO_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_SITE_INFO_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_GRP_SITE_INFO_C
	Description	: 관리자 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					 1	: 파라미터 값 오류
					-1	: initialize error
					-2	: UPDATE error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_SITE_INFO_C
(	@pSiteName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pIsUsed		bit
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if @pSiteName = '' or @pNoteText = ''
	begin
		set @oReturnNo = 1
		return
	end


	insert into dbo.KWT001_SG_WS_SITE_GROUP_MST
		(	cSiteGroup
		,	cSiteName
		,	cNoteText
		,	cIsUsed
		,	cHostIp
		,	cCreateTime
		)
	select	isnull(max(cSiteGroup),0) + 1
		,	@pSiteName
		,	@pNoteText
		,	@pIsUsed
		,	@pHostIp
		,	@vGetDate
	from	dbo.KWT001_SG_WS_SITE_GROUP_MST with(nolock)

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(100)
,@o2 varchar(150)
,@o3 int
,@sp int
exec dbo.KWP00105_SG_WS_GRP_SITE_INFO_C
 @pSiteGroup = 10001
,@pSiteName = ''
,@pNoteText = ''
,@pIsUsed = 1
,@pHostIp = ''
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_GRP_SITE_INFO_C to [opwebuser]
go

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

use SiteManager
go
if object_id('dbo.KWP00106_SG_WS_GRP_AUTH_LIST_D') is null
	exec ('create procedure dbo.KWP00106_SG_WS_GRP_AUTH_LIST_D as select 1')
--	drop procedure dbo.KWP00106_SG_WS_GRP_AUTH_LIST_D
go
/******************************************************************************
	name		: KWP00106_SG_WS_GRP_AUTH_LIST_D
	description	: 권한 그룹에서 제외
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00106_SG_WS_GRP_AUTH_LIST_D
(	@pAuthGroup		int
,	@pAdminList		varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	delete	a
	from	dbo.KWT001_SG_WS_MANGR_GROUP_MST as a with(updlock)
			inner join
			dbo.fnTbl2Int(@pAdminList,'|') as b
		on	a.cAdminNo		= b.cValue
	where	a.cAuthGroup	= @pAuthGroup

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00106_SG_WS_GRP_AUTH_LIST_D
 @pAuthGroup = 100200003
,@pAdminList = '|'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00106_SG_WS_GRP_AUTH_LIST_D to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00106_SG_WS_GRP_MENU_LIST_D') is null
	exec ('create procedure dbo.KWP00106_SG_WS_GRP_MENU_LIST_D as select 1')
--	drop procedure dbo.KWP00106_SG_WS_GRP_MENU_LIST_D
go
/******************************************************************************
	name		: KWP00106_SG_WS_GRP_MENU_LIST_D
	description	: 권한 그룹에서 제외
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00106_SG_WS_GRP_MENU_LIST_D
(	@pAuthGroup		int
,	@pMenuList		varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	delete	a
	from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE as a with(updlock)
			inner join
			dbo.fnTbl2Int(@pMenuList,'|') as b
		on	a.cMenuNo		= b.cValue
	where	a.cAuthGroup	= @pAuthGroup

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00106_SG_WS_GRP_MENU_LIST_D
 @pAuthGroup = 100200005
,@pMenuList = '100100003|'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00106_SG_WS_GRP_MENU_LIST_D to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_ADMIN_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_ADMIN_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_ADMIN_INFO_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_ADMIN_INFO_U
	Description	: 관리 유저 변경
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: password error
					-3	: duplicate name
					-4	: UPDATE error
					-5	: delete error
					-6	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-07-03	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_ADMIN_INFO_U
(	@pAdminNo		int
,	@pAdminName		nvarchar(20)
,	@pPassword		char(32)
,	@pAuthGroup		int
,	@pDeptNo		int
,	@pIsUsed		bit
,	@pNoteText		nvarchar(30)
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if len(@pPassword) between 1 and 31
	begin
		set @oReturnNo = -2
		return
	end

	-- 중복 이름 체크
	if exists (
		select	1
		from	dbo.KWT001_SG_WS_MANGR_LIST with(nolock)
		where	cAdminName	= @pAdminName
			and	cAdminNo	!= @pAdminNo
	)
	begin
		set @oReturnNo = -3
		return
	end


	begin tran
		set @oReturnNo = -4
		-- 관리 유저 내용 변경
		update	a
		set		cAdminName	= @pAdminName
			,	cPassword	= case @pPassword when '' then cPassword else @pPassword end
			,	cDeptNo		= @pDeptNo
			,	cIsUsed		= @pIsUsed
			,	cNoteText	= @pNoteText
			,	cHostIp		= @pHostIp
			,	cModifyTime	= @vGetDate
		from	dbo.KWT001_SG_WS_MANGR_LIST as a
		where	cAdminNo	= @pAdminNo

		if @@rowcount = 0
		begin
			if @@trancount > 0 rollback tran
			return
		end


		set @oReturnNo = -5
		-- 기존 권한 삭제
		delete
		from	dbo.KWT001_SG_WS_MANGR_GROUP_MST
		where	cAdminNo = @pAdminNo

		if @@rowcount > 1
		begin
			if @@trancount > 0 rollback tran
			return
		end

		if @pAuthGroup = 0
		begin
			commit tran
			set @oReturnNo = 0
			return
		end


		set @oReturnNo = -6
		-- 권한 부여
		insert into dbo.KWT001_SG_WS_MANGR_GROUP_MST
			(	cAuthGroup
			,	cAdminNo
			,	cCreateTime
			)
		values
			(	@pAuthGroup
			,	@pAdminNo
			,	@vGetDate
			)

		if @@rowcount = 0
		begin
			if @@trancount > 0 rollback tran
			return
		end
	commit tran


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
exec dbo.KWP00107_SG_WS_ADMIN_INFO_U
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

grant execute on dbo.KWP00107_SG_WS_ADMIN_INFO_U to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_ADMIN_PASSWD_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_ADMIN_PASSWD_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_ADMIN_PASSWD_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_ADMIN_PASSWD_U
	Description	: 관리자 비밀번호 수정
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: inValidate parameter error.[ @pAdminNo ]
					-3	: inValidate parameter error.[ @pPasswordOld ]
					-4	: inValidate parameter error.[ @pPasswordNew ]
					-5	: inValidate parameter error.[ @pPasswordOld = @pPasswordNew ]
					-7	: EXCUTE UPDATE-SQL( Record Update fail )

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-12	Hoon-Sik,Jin	1.CREATE
*******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_ADMIN_PASSWD_U
(	@pAdminNo		int				-- 관리자 번호
,	@pPasswordOld	char(32)		-- 관리자 패스워드
,	@pPasswordNew	char(32)		-- 새로운 패스워드
,	@pHostIp		varchar(15)		-- 수정한 IP
,	@oReturnNo		int 	output	-- 리턴값

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	--- Validate parameter error ---
	if len(@pAdminNo) < 5
	begin
		set @oReturnNo = -2
		return
	end

	if len(rtrim(@pPasswordOld)) < 30
	begin
		set @oReturnNo = -3
		return
	end

	if len(rtrim(@pPasswordNew)) < 30
	begin
		set @oReturnNo = -4
		return
	end

	if @pPasswordOld = @pPasswordNew
	begin
		set @oReturnNo = -5
		return
	end
	--- Validate parameter error ---


	update	a
	set		cPassword	= @pPasswordNew
		,	cHostIp		= @pHostIp
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_MANGR_LIST as a
	where	cAdminNo	= @pAdminNo
		and	cPassword	= @pPasswordOld

	if @@rowcount != 1
	begin
		set @oReturnNo = -7
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @p1 int
,@p2 char(32)
,@p3 char(32)
,@sp int
exec dbo.KWP00107_SG_WS_ADMIN_PASSWD_U
 @pAdminNo = @p1
,@pPasswordOld = @p2
,@pPasswordNew = @p3
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_ADMIN_PASSWD_U to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U
go
/******************************************************************************
	name		: KWP00107_SG_WS_GRP_AUTH_INFO_U
	description	: 권한 그룹내용 변경하기
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: duplicate group name
					-3	: UPDATE error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U
(	@pSiteGroup		smallint
,	@pCommGroup		int
,	@pCommName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pHostIp		varchar(15)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
		where	cSiteGroup	= @pSiteGroup
			and	cCommGroup	!= @pCommGroup
			and	cCommName	= @pCommName
	)
	begin
		set @oReturnNo = -2
		return
	end


	-- 그룹 기본정보
	update	a
	set		cCommName	= @pCommName
		,	cNoteText	= @pNoteText
		,	cHostIp		= @pHostIp
		,	cIsUsed		= @pIsUsed
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
	where	cCommGroup	= @pCommGroup
		and	cSiteGroup	= @pSiteGroup

	if @@rowcount != 1
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
 @o1 int
,@o2 varchar(100)
,@o3 bit
,@o4 varchar(150)
,@sp int
exec dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U
 @pCommGroup = 100200004
,@o_cAuthGroup = @o1 output
,@o_cAuthName = @o2 output
,@oIsUsed = @o3 output
,@oNoteText = @o4 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_GRP_COMM_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_GRP_COMM_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_GRP_COMM_INFO_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_GRP_COMM_INFO_U
	Description	: 관리자 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					 1	: 파라미터 값 오류
					-1	: initialize error
					-2	: UPDATE error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_GRP_COMM_INFO_U
(	@pCommGroup		int
,	@pCommName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pIsUsed		bit
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if @pCommName = '' or @pNoteText = ''
	begin
		set @oReturnNo = 1
		return
	end


	update	a
	set		cCommName	= @pCommName
		,	cNoteText	= @pNoteText
		,	cIsUsed		= @pIsUsed
		,	cHostIp		= @pHostIp
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
	where	cCommGroup	= @pCommGroup

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(100)
,@o2 varchar(150)
,@o3 int
,@sp int
exec dbo.KWP00107_SG_WS_GRP_COMM_INFO_U
 @pCommGroup = 100100001
,@pCommName = ''
,@pNoteText = ''
,@pIsUsed = 1
,@pHostIp = ''
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_GRP_COMM_INFO_U to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U
go
/******************************************************************************
	name		: KWP00107_SG_WS_GRP_COMM_SEQ_U
	description	: 사이트 코드에 대한 그룹코드 순서 변경
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U
(	@pSiteGroup		smallint
,	@pCommGroup		int
,	@pSeqNoOld		tinyint
,	@pSeqNoNew		tinyint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	begin tran
		-- 작은 수에서 큰 수로 변경되는 경우
		if @pSeqNoNew > @pSeqNoOld
		begin
			update	a
			set		cOrderBy	-= 1
			from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			where	cSiteGroup	= @pSiteGroup
				and	cOrderBy	between @pSeqNoOld and @pSeqNoNew

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -3
				return
			end


			update	a
			set		cOrderBy	= @pSeqNoNew
			from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			where	cSiteGroup	= @pSiteGroup
				and	cCommGroup	= @pCommGroup

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -2
				return
			end
		end
		-- 큰 수에서 작은 수로 변경되는 경우
		else if @pSeqNoNew < @pSeqNoOld
		begin
			update	a
			set		cOrderBy	+= 1
			from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			where	cSiteGroup	= @pSiteGroup
				and	cOrderBy	between @pSeqNoNew and @pSeqNoOld

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -3
				return
			end


			update	a
			set		cOrderBy	= @pSeqNoNew
			from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			where	cSiteGroup	= @pSiteGroup
				and	cCommGroup	= @pCommGroup

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -2
				return
			end
		end
	commit tran


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @SP int
exec dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U
 @pSiteGroup = 10003
,@pCommGroup = 100300003
,@pSeqNoOld = 7
,@pSeqNoNew = 3
,@oReturnNo = @SP output

print @SP

select	*
from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
where	cSiteGroup = 10003
order by cOrderBy
*/
go

grant execute on dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_GRP_SITE_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_GRP_SITE_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_GRP_SITE_INFO_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_GRP_SITE_INFO_U
	Description	: 관리자 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					 1	: 파라미터 값 오류
					-1	: initialize error
					-2	: UPDATE error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_GRP_SITE_INFO_U
(	@pSiteGroup		int
,	@pSiteName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pIsUsed		bit
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if @pSiteName = '' or @pNoteText = ''
	begin
		set @oReturnNo = 1
		return
	end


	update	a
	set		cSiteName	= @pSiteName
		,	cNoteText	= @pNoteText
		,	cIsUsed		= @pIsUsed
		,	cHostIp		= @pHostIp
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_SITE_GROUP_MST as a
	where	cSiteGroup	= @pSiteGroup

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(100)
,@o2 varchar(150)
,@o3 int
,@sp int
exec dbo.KWP00107_SG_WS_GRP_SITE_INFO_U
 @pSiteGroup = 10001
,@pSiteName = ''
,@pNoteText = ''
,@pIsUsed = 1
,@pHostIp = ''
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_GRP_SITE_INFO_U to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_MENU_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_MENU_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_MENU_INFO_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_MENU_INFO_U
	Description	: 기존 메뉴 변경
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_MENU_INFO_U
(	@pMenuNo		int
,	@pMenuName		nvarchar(10)
,	@pExecUrl		varchar(120)
,	@pGroupOld		int
,	@pGroupNew		int
,	@pIsUsed		bit
,	@pSeqNoOld		tinyint
,	@pSeqNoNew		tinyint
,	@pNoteText		nvarchar(50)
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vMenuNo int
		,	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	-- 그룹 이동
	if @pGroupOld != @pGroupNew
	begin
		select	@vMenuNo	= isnull(max(cMenuNo),(1000+right(@pGroupNew,1))*100000) + 1
		from	dbo.KWT001_SG_WS_MENU_LIST
		where	cMenuGroup	= @pGroupNew

		begin tran
			-- 기존 메뉴 삭제
			delete
			from	dbo.KWT001_SG_WS_MENU_LIST
			where	cMenuNo = @pMenuNo

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -2
				return
			end


			-- 새로운 메뉴로 등록
			insert into dbo.KWT001_SG_WS_MENU_LIST
				(	cMenuNo
				,	cMenuName
				,	cMenuGroup
				,	cExecUrl
				,	cNoteText
				,	cIsUsed
				,	cOrderBy
				,	cHostIp
				,	cCreateTime
				)
			select	@vMenuNo
				,	@pMenuName
				,	@pGroupNew
				,	@pExecUrl
				,	@pNoteText
				,	@pIsUsed
				,	isnull(max(cOrderBy),0) + 1
				,	@pHostIp
				,	@vGetDate
			from	dbo.KWT001_SG_WS_MENU_LIST
			where	cMenuGroup	= @pGroupNew

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -3
				return
			end


			-- 기존 권한 관계 끊기
			delete
			from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE
			where	cMenuNo = @pMenuNo

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -4
				return
			end
		commit tran


		set @oReturnNo = 0
		return
	end



	-- 내용 변경
	update	a
	set		cMenuName	= @pMenuName
		,	cExecUrl	= @pExecUrl
		,	cNoteText	= @pNoteText
		,	cIsUsed		= @pIsUsed
		,	cHostIp		= @pHostIp
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_MENU_LIST as a
	where	cMenuNo		= @pMenuNo

	if @@rowcount = 0
	begin
		set @oReturnNo = -5
		return
	end

	-- 순서 변경이 없는 경우 여기서 중단
	if @pSeqNoOld = @pSeqNoNew
	begin
		set @oReturnNo = 0
		return
	end



	begin tran
		-- 변경 할 메뉴 255로 임시 처리
		update	a
		set		cOrderBy	= 255
		from	dbo.KWT001_SG_WS_MENU_LIST as a
		where	cMenuGroup	= @pGroupOld
			and	cMenuNo		= @pMenuNo

		if @@rowcount = 0
		begin
			set @oReturnNo = -6
			return
		end


		if @pSeqNoNew > @pSeqNoOld
		begin
			update	a
			set		cOrderBy	-= 1
			from	dbo.KWT001_SG_WS_MENU_LIST as a
			where	cMenuGroup	= @pGroupOld
				and	cOrderBy	between @pSeqNoOld and @pSeqNoNew

			if @@rowcount = 0
			begin
				set @oReturnNo = -7
				return
			end


			update	a
			set		cOrderBy	= @pSeqNoNew
			from	dbo.KWT001_SG_WS_MENU_LIST as a
			where	cMenuGroup	= @pGroupOld
				and	cMenuNo		= @pMenuNo

			if @@rowcount = 0
			begin
				set @oReturnNo = -8
				return
			end
		end
		-- 큰 수에서 작은 수로 변경되는 경우
		else if @pSeqNoNew < @pSeqNoOld
		begin
			update	a
			set		cOrderBy	+= 1
			from	dbo.KWT001_SG_WS_MENU_LIST as a
			where	cMenuGroup	= @pGroupOld
				and	cOrderBy	between @pSeqNoNew and @pSeqNoOld

			if @@rowcount = 0
			begin
				set @oReturnNo = -9
				return
			end


			update	a
			set		cOrderBy	= @pSeqNoNew
			from	dbo.KWT001_SG_WS_MENU_LIST as a
			where	cMenuGroup	= @pGroupOld
				and	cMenuNo		= @pMenuNo

			if @@rowcount = 0
			begin
				set @oReturnNo = -10
				return
			end
		end
	commit tran



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
exec dbo.KWP00107_SG_WS_MENU_INFO_U
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

grant execute on dbo.KWP00107_SG_WS_MENU_INFO_U to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00201_SG_WS_BLOCK_DRPDN_R') is null
	exec ('create procedure dbo.KWP00201_SG_WS_BLOCK_DRPDN_R as select 1')
--	drop procedure dbo.KWP00201_SG_WS_BLOCK_DRPDN_R
go
/******************************************************************************
	Name		: KWP00201_SG_WS_BLOCK_DRPDN_R
	Description	: 유저 블럭 드롭다운 리스트
	Reference	:
	Result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2012-03-11	Hoon-Sik,Jin	1.초기생성
 ******************************************************************************/
alter procedure dbo.KWP00201_SG_WS_BLOCK_DRPDN_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	reason_no
		,	reason_text
	from	dbo.KWT002_SG_WS_BLOCK_MST with(nolock)
	order by reason_no


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
exec dbo.KWP00201_SG_WS_BLOCK_DRPDN_R
@oReturnNo = 1
*/
go

grant execute on dbo.KWP00201_SG_WS_BLOCK_DRPDN_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00201_SG_WS_HERO_DRPDN_R') is null
	exec ('create procedure dbo.KWP00201_SG_WS_HERO_DRPDN_R as select 1')
--	drop procedure dbo.KWP00201_SG_WS_HERO_DRPDN_R
go
/******************************************************************************
	Name		: KWP00201_SG_WS_HERO_DRPDN_R
	Description	: 메뉴 그룹 드롭다운 리스트
	Reference	:
	Result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2012-03-11	Hoon-Sik,Jin	1.초기생성
 ******************************************************************************/
alter procedure dbo.KWP00201_SG_WS_HERO_DRPDN_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cSeqNo
	from	dbo.KWT002_SG_WS_SEQ_LIST with(nolock)
	where	cSeqNo < 700


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
exec dbo.KWP00201_SG_WS_HERO_DRPDN_R
@oReturnNo = 1
*/
go

grant execute on dbo.KWP00201_SG_WS_HERO_DRPDN_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00201_SG_WS_ITEM_DRPDN_R') is null
	exec ('create procedure dbo.KWP00201_SG_WS_ITEM_DRPDN_R as select 1')
--	drop procedure dbo.KWP00201_SG_WS_ITEM_DRPDN_R
go
/******************************************************************************
	Name		: dbo.KWP00201_SG_WS_ITEM_DRPDN_R
	Description	: 아이템/영웅 드롭다운 리스트
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-12	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00201_SG_WS_ITEM_DRPDN_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cSeqNo
	from	dbo.KWT002_SG_WS_SEQ_LIST with(nolock)
	where	cSeqNo < 700


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00201_SG_WS_ITEM_DRPDN_R
@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00201_SG_WS_ITEM_DRPDN_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00202_SG_WS_ORDER_LIST_R') is null
	exec ('create procedure dbo.KWP00202_SG_WS_ORDER_LIST_R as select 1')
--	drop procedure dbo.KWP00202_SG_WS_ORDER_LIST_R
go
/******************************************************************************
	name		: KWP00202_SG_WS_ORDER_LIST_R
	description	: 주문번호에 해당하는 유저번호 찾기
	reference	:
	result		: @oReturnNo
					 0	: Success
					 1	: 검색된 유저번호 없음
					-1	: initialize error
					-2	: 주문번호 오류
					-3	: 검색 오류

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2014-03-03	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00202_SG_WS_ORDER_LIST_R
(	@pOrderNo		varchar(max)
,	@pStartDate		int
,	@pFinishDate	int
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	distinct
			cWorkDate
		,	cText4 as cOrderNo
	from	dbo.fnTbl2NString(@pOrderNo,char(10)) as a
			inner join
			LogMasterLive.dbo.tGameLog_15 as b with(nolock)
		on	b.cText4	= a.cValue
	where	cLogType	= 20050
		and	cWorkDate	between @pStartDate and @pFinishDate
	order by cOrderNo
	option (recompile)


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00202_SG_WS_ORDER_LIST_R
 @pOrderNo = '504216529694760
465960356849418
491951160917002
479735758805213
479766065468849
491512680960857
479766138802175
485191728259617
523872161062276
518841124896024'
,@pStartDate = '20130301'
,@pFinishDate = '20140302'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00202_SG_WS_ORDER_LIST_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R') is null
	exec ('create procedure dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R as select 1')
--	drop procedure dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R
go
/******************************************************************************
	name		: dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R
	description	: 영웅, 아이템, 플레이어 복구 내역
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

		cAction
			20010 : 영웅 삭제
			20009 : 영웅 복구
			20019 : 아이템 삭제
			20018 : 아이템 복구
			20018 : 착용 아이템 복구
			20000 : 플레이어 삭제
			20052 : 플레이어 복구

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-04-23	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R
(	@pPublisher		bigint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cServerNo
		,	cPlayerNo
		,	cNickName
		,	cAction
		,	cCreateNo
		,	cDeleteNo
		,	cObjectNo
		,	cObjectKey
		,	cHostIp
		,	cCreateTime as cCreateTimes
	from	dbo.KWT002_SG_WS_RECOVERY_LOG with(nolock)
	where	cPublisher	= @pPublisher


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R
 @pPublisher = 88205865609415265
,@oReturnNo = @sp output

print @sp

select cPublisher,count(*) as rowcnt
from dbo.KWT002_SG_WS_RECOVERY_LOG
group by cPublisher
having count(*) > 1
order by rowcnt desc

dbo.KWT002_SG_WS_RECOVERY_LOG
where	cPublisher	= 88300038752231648
*/
go

grant execute on dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R to [opwebuser]

use SiteManager
go
if object_id('dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R') is null
	exec ('create procedure dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R as select 1')
--	drop procedure dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R
go
/******************************************************************************
	name		: KWP00204_SG_WS_ORDER_ACCOUNT_R
	description	: 주문번호에 해당하는 유저번호 찾기
	reference	:
	result		: @oReturnNo
					 0	: Success
					 1	: 검색된 유저번호 없음
					-1	: initialize error
					-2	: 주문번호 오류
					-3	: 검색 오류

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R
(	@pServerNo		tinyint
,	@pOrderNo		varchar(64)
,	@pStartDate		int
,	@pFinishDate	int
,	@oPlayerNo		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vSQL nvarchar(400)
		,	@vVar nvarchar(200)
	select	@oReturnNo = -1
		,	@oPlayerNo = 0

	if len(@pOrderNo) < 35
	begin
		set @oReturnNo = -2
		return
	end


	set @vVar = '
			@pOrderNo		nvarchar(64)
		,	@pServerNo		tinyint
		,	@pStartDate		int
		,	@pFinishDate	int
		,	@oPlayerNo		bigint	output'
	set @vSQL = '
		select	top 1
				@oPlayerNo	= cAccountNo
		from	LogMasterLive.dbo.tGameLog_15 with(nolock)
		where	cText4		= @pOrderNo
			and	cServerNo	= @pServerNo
			and	cLogType	= 20053
			and	cWorkDate	between @pStartDate and @pFinishDate
		option (recompile)'

	print @vVar
	print @vSQL
	exec sp_executesql @vSQL
		,	@vVar
		,	@pOrderNo
		,	@pServerNo
		,	@pStartDate
		,	@pFinishDate
		,	@oPlayerNo	output

	if @@error != 0
	begin
		set @oReturnNo = -3
		return
	end


	if isnull(@oPlayerNo,0) = 0
	begin
		set @oReturnNo = 1
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @p1 bigint
,@sp int
exec dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R
 @pServerNo = 1
,@pOrderNo = '12999763169054705758.1376548775089802'
,@pStartDate = '2014-01-01'
,@pFinishDate = '2014-02-01'
,@oPlayerNo = @p1 output
,@oReturnNo = @sp output

print @p1
print @sp
*/
go

grant execute on dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00204_SG_WS_ORDER_INFO_R') is null
	exec ('create procedure dbo.KWP00204_SG_WS_ORDER_INFO_R as select 1')
--	drop procedure dbo.KWP00204_SG_WS_ORDER_INFO_R
go
/******************************************************************************
	name		: KWP00204_SG_WS_ORDER_INFO_R
	description	: 주문번호에 해당하는 유저번호 찾기
	reference	:
	result		: @oReturnNo
					 0	: Success
					 1	: 검색된 유저번호 없음
					-1	: initialize error
					-2	: 주문번호 오류
					-3	: 검색 오류

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00204_SG_WS_ORDER_INFO_R
(	@pOrderNo		varchar(64)
,	@pStartDate		int
,	@pFinishDate	int
,	@oWorkDate		int			output
,	@oWorldNo		tinyint		output
,	@oPlayerNo		bigint		output
,	@oCreateTime	datetime	output
,	@oReturnNo		int			output

) as
begin
	set nocount on
	select	@oWorkDate		= 0
		,	@oWorldNo		= 0
		,	@oPlayerNo		= 0
		,	@oCreateTime	= 0
		,	@oReturnNo		= -1

	select	top 1
			@oWorkDate		= cWorkDate
		,	@oWorldNo		= cServerNo
		,	@oPlayerNo		= cAccountNo
		,	@oCreateTime	= cCreateTime
	from	LogMasterLive.dbo.tGameLog_15 with(nolock)
	where	cText4			= @pOrderNo
		and	cLogType		= 20050
		and	cWorkDate		between @pStartDate and @pFinishDate
	option (recompile)

	if isnull(@oPlayerNo,0) = 0
	begin
		set @oReturnNo = 1
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 int
,@o2 int
,@o3 bigint
,@o4 datetime
,@sp int
exec dbo.KWP00204_SG_WS_ORDER_INFO_R
 @pOrderNo = '12999763169054705758.1339841401669214'
,@pStartDate = '2013-04-01'
,@pFinishDate = '2013-04-10'
,@oWorkDate = @o1 output
,@oWorldNo = @o2 output
,@oPlayerNo = @o3 output
,@oCreateTime = @o4 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @sp
*/
go

grant execute on dbo.KWP00204_SG_WS_ORDER_INFO_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00205_SG_WS_GOODS_LOG_C') is null
	exec ('create procedure dbo.KWP00205_SG_WS_GOODS_LOG_C as select 1')
--	drop procedure dbo.KWP00205_SG_WS_GOODS_LOG_C
go
/******************************************************************************
	name		: dbo.KWP00205_SG_WS_GOODS_LOG_C
	description	: 선물 지급 및 인벤토리 수정
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: Insert error

		@pAction
			-- 선물
			01	: 명예 지급
			02	: 골드 지급
			03	: 캐럿 지급
			04	: 스테미나 지급
			05	: 에너지 지급
			06	: 지정 영웅 지급
			07	: 지정 아이템 지급
			08	: 랜덤 영웅 지급
			09	: 랜덤 아이템 지급

			21	: 명예 회수
			22	: 골드 회수
			23	: 캐럿 회수
			24	: 스테미나 회수
			25	: 에너지 회수
			26	: 지정 영웅 회수
			27	: 지정 아이템 회수
			28	: 랜덤 영웅 회수
			29	: 랜덤 아이템 회수

			-- 확장 속성
			61	: 4배속 만료 시간 증가
			62	: 경험치 부스터 만료 시간 증가
			63	: 타임어택 키 증가
			64	: 타임어택 만료 시간 증가

			71	: 4배속 만료 시간 감소
			72	: 경험치 부스터 만료 시간 감소
			73	: 타임어택 키 감소
			74	: 타임어택 만료 시간 감소

			-- 인벤 수치 변경
			81	: 명예 지급
			82	: 골드 지급
			83	: 캐럿 지급
			84	: 스테미나 지급
			85	: 에너지 지급
			103	: 보상 캐럿 지급
			121	: 캐럿 포인트 지급

			91	: 명예 회수
			92	: 골드 회수
			93	: 캐럿 회수
			94	: 스테미나 회수
			95	: 에너지 회수
			113	: 보상 캐럿 회수
			131	: 캐럿 포인트 회수

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-04-15	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00205_SG_WS_GOODS_LOG_C
(	@pServerNo		int				-- 서버 번호
,	@pPlayerNo		bigint			-- 유저 번호
,	@pPublisher		tinyint			-- 퍼블리셔 번호
,	@pMailNo		bigint			-- 선물 번호
,	@pNickName		nvarchar(16)	-- 닉네임
,	@pAction		varchar(99)		-- 선물 타입
,	@pValueOld		varchar(99)		-- 선물 값
,	@pValueNew		varchar(99)		-- 이전 값
,	@pAdminNo		int				-- 관리자 번호
,	@pHostIp		varchar(15)		-- 아이피 주소
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vWorkDate int
		,	@vGetDate datetime = getdate()
	select	@oReturnNo	= -1
		,	@pMailNo	= nullif(@pMailNo,0)
		,	@vWorkDate	= convert(char(8),getdate(),112)

	insert into dbo.KWT002_SG_WS_GOODS_LOG
		(	cWorkDate
		,	cServerNo
		,	cPlayerNo
		,	cNickName
		,	cPublisher
		,	cMailNo
		,	cAction
		,	cValueNew
		,	cValueOld
		,	cTryCnt
		,	cAdminNo
		,	cHostIp
		,	cCreateTime
		)
	select	@vWorkDate
		,	@pServerNo
		,	@pPlayerNo
		,	@pNickName
		,	@pPublisher
		,	isnull(@pMailNo,1)
		,	a.cValue
		,	convert(numeric(19,11),convert(float,b.cValue))
		,	convert(numeric(19,11),convert(float,c.cValue))
		,	1
		,	@pAdminNo
		,	@pHostIp
		,	@vGetDate
	from	dbo.fnTbl2Int(@pAction,'|')			as a
			inner join
			dbo.fnTbl2String(@pValueNew,'|')	as b
		on	b.cSeqNo	= a.cSeqNo
			inner join
			dbo.fnTbl2String(@pValueOld,'|')	as c
		on	c.cSeqNo	= a.cSeqNo
	where	a.cValue	> ''

	if @@error != 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00205_SG_WS_GOODS_LOG_C
 @pServerNo = 1
,@pPlayerNo = 337164
,@pNickName = '노리타'
,@pPublisher = 89246305501125009
,@pAction = 3
,@pValueOld = 100
,@pValueNew = 150
,@pAdminNo = 100000001
,@pHostIp = '222.117.240.137'
,@oReturnNo = @sp output

print @sp


truncate table dbo.KWT002_SG_WS_GOODS_LOG
*/
go

grant execute on dbo.KWP00205_SG_WS_GOODS_LOG_C to [opwebuser]

use SiteManager
go
if object_id('dbo.KWP00205_SG_WS_RECOVERY_LOG_C') is null
	exec ('create procedure dbo.KWP00205_SG_WS_RECOVERY_LOG_C as select 1')
--	drop procedure dbo.KWP00205_SG_WS_RECOVERY_LOG_C
go
/******************************************************************************
	name		: dbo.KWP00205_SG_WS_RECOVERY_LOG_C
	description	: 영웅, 아이템, 플레이어 복구
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: Insert error

		@pAction
			10 : 영웅 삭제
			11 : 영웅 복구
			20 : 아이템 삭제
			21 : 아이템 복구
			22 : 착용 아이템 복구
			30 : 플레이어 삭제
			31 : 플레이어 복구

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-04-15	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00205_SG_WS_RECOVERY_LOG_C
(	@pServerNo		int
,	@pPlayerNo		bigint
,	@pNickName		nvarchar(16)
,	@pPublisher		bigint
,	@pAction		smallint
,	@pCreateNo		tinyint
,	@pDeleteNo		tinyint
,	@pObjectNo		bigint
,	@pObjectKey		smallint
,	@pAdminNo		int
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT002_SG_WS_RECOVERY_LOG
		(	cWorkDate
		,	cServerNo
		,	cPlayerNo
		,	cNickName
		,	cPublisher
		,	cAction
		,	cCreateNo
		,	cDeleteNo
		,	cObjectNo
		,	cObjectKey
		,	cTryCnt
		,	cAdminNo
		,	cHostIp
		,	cCreateTime
		)
	values
		(	convert(char(8),@vGetDate,112)
		,	@pServerNo
		,	@pPlayerNo
		,	@pNickName
		,	@pPublisher
		,	@pAction
		,	@pCreateNo
		,	@pDeleteNo
		,	@pObjectNo
		,	@pObjectKey
		,	1
		,	@pAdminNo
		,	@pHostIp
		,	@vGetDate
		)

	if @@error != 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00205_SG_WS_RECOVERY_LOG_C
 @pServerNo = 1
,@pPlayerNo = 222274
,@pNickName = '이유반'
,@pPublisher = 88151987532876768
,@pAction = 11
,@pCreateNo = 10
,@pDeleteNo = 0
,@pObjectNo = 27363964
,@pAdminNo = 100000005
,@pHostIp = '222.117.240.137'
,@oReturnNo = @sp output

print @sp

dbo.KWT002_SG_WS_RECOVERY_LOG
where	cPlayerNo = 337164
*/
go

grant execute on dbo.KWP00205_SG_WS_RECOVERY_LOG_C to [opwebuser]

use SiteManager
go
if object_id('dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R') is null
	exec('create procedure dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R as select 1')
--	drop procedure dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R
go
/******************************************************************************
	name		: KWP00301_SG_WS_GAME_TABLE_DRPDN_R
	description	: 관리 테이블 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R
(	@pGameNo		int
,	@pDatabase		varchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	cTableNo
		,	cTableName
		,	cTableText
	from	dbo.KWT003_SG_WS_GAME_TABLE
	where	cGameNo		= @pGameNo
		and	cDatabase	= @pDatabase


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R
 @pTableType = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00301_SG_WS_GAME_TABLE_DRPDN_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00302_SG_WS_GAME_COLUMN_LIST_R') is null
	exec('create procedure dbo.KWP00302_SG_WS_GAME_COLUMN_LIST_R as select 1')
--	drop procedure dbo.KWP00302_SG_WS_GAME_COLUMN_LIST_R
go
/******************************************************************************
	name		: KWP00302_SG_WS_GAME_COLUMN_LIST_R
	description	: 관리 테이블 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00302_SG_WS_GAME_COLUMN_LIST_R
(	@pTableNo		int
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	cColumnNo
		,	cColumnText
		,	cIsUsed
		,	cVitals
	from	dbo.KWT003_SG_WS_GAME_COLUMN
	where	cTableNo = @pTableNo


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00302_SG_WS_GAME_COLUMN_LIST_R
 @pTableNo = 1000002
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.KWP00302_SG_WS_GAME_COLUMN_LIST_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R') is null
	exec('create procedure dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R as select 1')
--	drop procedure dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R
go
/******************************************************************************
	name		: KWP00302_SG_WS_GAME_TABLE_LIST_R
	description	: 관리 테이블 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R
(	@pGameNo		int
,	@pDatabase		varchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	cTableNo
		,	cDatabase
		,	cTableId
		,	cTableName
		,	cTableText
		,	cIsUsed
	from	dbo.KWT003_SG_WS_GAME_TABLE
	where	cGameNo		= @pGameNo
		and	(	cDatabase	= @pDatabase
			or	@pDatabase	= ''
			)


	set @oReturnNo = 0
	set nocount off
end
/*
set statistics io on
use SiteManager
declare @sp int
exec dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R
 @pGameNo = 20150001
,@pDatabase = ''
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.KWP00302_SG_WS_GAME_TABLE_LIST_R to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_GAME_COLUMN_C') is null
	exec ('create procedure dbo.KWP00305_SG_WS_GAME_COLUMN_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_GAME_COLUMN_C
go
/******************************************************************************
	Name		: dbo.KWP00305_SG_WS_GAME_COLUMN_C
	Description	: 테이블 리스트
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_GAME_COLUMN_C
(	@pTableNo		int
,	@pColumns		varchar(50)
,	@pComment		nvarchar(1000)
,	@pVitalCols		varchar(30)
,	@pUsingCols		varchar(30)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set transaction isolation level read uncommitted

	declare	@vGetDate	datetime = getdate()
		,	@vErrorMsg	nvarchar(max) = ''
	set @oReturnNo = -1

	create table #tmpColumnInfo
	(	cColumnNo	int				not null
	,	cColumnText	nvarchar(16)	not null
	,	cVitals		bit				not null
	,	cIsUsed		bit				not null
	)


	begin try
		begin tran
			set @oReturnNo = 2
			-- @pTableNo 있으면 삭제
			delete
			from	dbo.KWT003_SG_WS_GAME_COLUMN
			where	cTableNo = @pTableNo


			set @oReturnNo = 3
			insert into #tmpColumnInfo
				(	cColumnNo
				,	cColumnText
				,	cVitals
				,	cIsUsed
				)
			exec dbo.uspArray2Table
					@pString0 = @pColumns
				,	@pString1 = @pComment
				,	@pString2 = @pVitalCols
				,	@pString3 = @pUsingCols

			if @@error != 0 or @@rowcount = 0
			begin
				select	@oReturnNo = -3
					,	@vErrorMsg = '@pTableNo = '+ rtrim(@pTableNo)
					,	@vErrorMsg += ', @pColumns = '+ rtrim(@pColumns)
					,	@vErrorMsg += ', @pComment = '+ rtrim(@pComment)
					,	@vErrorMsg += ', @pVitalCols = '+ rtrim(@pVitalCols)
					,	@vErrorMsg += ', @pUsingCols = '+ rtrim(@pUsingCols)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end


			set @oReturnNo = 4
			insert into dbo.KWT003_SG_WS_GAME_COLUMN
				(	cTableNo
				,	cColumnNo
				,	cColumnText
				,	cVitals
				,	cIsUsed
				,	cCreateTime
				)
			select	@pTableNo
				,	cColumnNo
				,	nullif(cColumnText,'')
				,	cVitals
				,	cIsUsed
				,	@vGetDate
			from	#tmpColumnInfo
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran
		drop table #tmpColumnInfo

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	drop table #tmpColumnInfo
	set @oReturnNo = 0

	return 0
end
/*
set statistics io on
use SiteManager
declare @rt int
exec dbo.KWP00305_SG_WS_GAME_COLUMN_C
 @pTableName = ''
,@oReturnNo = @rt out

print @rt
*/
go

grant execute on dbo.KWP00305_SG_WS_GAME_COLUMN_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_GAME_TABLE_C') is null
	exec('create procedure dbo.KWP00305_SG_WS_GAME_TABLE_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_GAME_TABLE_C
go
/******************************************************************************
	name		: dbo.KWP00305_SG_WS_GAME_TABLE_C
	description	: 관리 테이블 추가
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_GAME_TABLE_C
(	@pGameNo		int
,	@pDatabase		varchar(20)
,	@pTableId		int
,	@pTableName		varchar(50)
,	@pTableText		nvarchar(16)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set transaction isolation level read uncommitted

	declare @vGetDate datetime = getdate()
	set @oReturnNo = -1

	if @pTableId = 0 or len(@pDatabase) < 1 or @pGameNo < 20150000
	begin
		set @oReturnNo = -2
		return
	end

	-- 테이블이 이미 존재하는 경우 처리
	if exists (
		select	1
		from	dbo.KWT003_SG_WS_GAME_TABLE
		where	cGameNo		= @pGameNo
			and	cDatabase	= @pDatabase
			and	cTableId	= @pTableId
	)
	begin
		set @oReturnNo = -3
		return
	end


	set @oReturnNo = 4
	insert into dbo.KWT003_SG_WS_GAME_TABLE
		(	cTableNo
		,	cGameNo
		,	cDatabase
		,	cTableId
		,	cTableName
		,	cTableText
		,	cIsUsed
		,	cCreateTime
		)
	values
		(	next value for dbo.sTableNo
		,	@pGameNo
		,	@pDatabase
		,	@pTableId
		,	@pTableName
		,	@pTableText
		,	@pIsUsed
		,	@vGetDate
		)


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00305_SG_WS_GAME_TABLE_C
 @pGameNo = 20150001
,@pDatabase = ''
,@pTableId = 1
,@pTableName = ''
,@pTableText = N''
,@pIsUsed = 1
,@oReturnNo = @sp out

print @sp
*/
go

grant execute on dbo.KWP00305_SG_WS_GAME_TABLE_C to [opwebuser]
go

use SiteManager
go
if object_id('dbo.KWP00307_SG_WS_GAME_TABLE_U') is null
	exec('create procedure dbo.KWP00307_SG_WS_GAME_TABLE_U as select 1')
--	drop procedure dbo.KWP00307_SG_WS_GAME_TABLE_U
go
/******************************************************************************
	name		: KWP00307_SG_WS_GAME_TABLE_U
	description	: 관리 테이블 설명 수정
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-08-13	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00307_SG_WS_GAME_TABLE_U
(	@pTableNo		int
,	@pTableText		nvarchar(16)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	update	a
	set		cTableText	= @pTableText
		,	cIsUsed		= @pIsUsed
	from	dbo.KWT003_SG_WS_GAME_TABLE as a
	where	cTableNo	= @pTableNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00307_SG_WS_GAME_TABLE_U
 @pTableNo = 1000001
,@pTableText = ''
,@pIsUsed = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00307_SG_WS_GAME_TABLE_U to [opwebuser]
go

use SiteManager
go
if object_id('dbo.uspGetArray2Table') is null
	exec ('create procedure dbo.uspGetArray2Table as select 1')
--	drop procedure dbo.uspGetArray2Table
go
/******************************************************************************
	Name		: dbo.uspGetArray2Table
	Description	: Array형 문자열을 Table 형태로 변환
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArray2Table
(	@pString0	nvarchar(2000)
,	@pString1	nvarchar(2000) = ''
,	@pString2	nvarchar(2000) = ''
,	@pString3	nvarchar(2000) = ''
,	@pString4	nvarchar(2000) = ''
,	@pString5	nvarchar(2000) = ''
,	@pString6	nvarchar(2000) = ''
,	@pString7	nvarchar(2000) = ''
,	@pString8	nvarchar(2000) = ''
,	@pString9	nvarchar(2000) = ''

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vTmp1 varchar(100) = ''
		,	@vTmp2 varchar(100) = ''
		,	@vSeqNo int
		,	@vStart int = 1
		,	@vLimit int = len(@pString0) - len(replace(@pString0,'|',''))
		,	@vStr0 nvarchar(90)
		,	@vStr1 nvarchar(90)
		,	@vStr2 nvarchar(90)
		,	@vStr3 nvarchar(90)
		,	@vStr4 nvarchar(90)
		,	@vStr5 nvarchar(90)
		,	@vStr6 nvarchar(90)
		,	@vStr7 nvarchar(90)
		,	@vStr8 nvarchar(90)
		,	@vStr9 nvarchar(90)
		,	@vCols varchar(100) = 'c0,c1,c2,c3,c4,c5,c6,c7,c8,c9'
		,	@vSQL nvarchar(max) = ''

	if @pString1 = '' set @vSeqNo = 1
	else if @pString2 = '' set @vSeqNo = 2
	else if @pString3 = '' set @vSeqNo = 3
	else if @pString4 = '' set @vSeqNo = 4
	else if @pString5 = '' set @vSeqNo = 5
	else if @pString6 = '' set @vSeqNo = 6
	else if @pString7 = '' set @vSeqNo = 7
	else if @pString8 = '' set @vSeqNo = 8
	else if @pString9 = '' set @vSeqNo = 9

	select	@pString0 = case @pString0 when '' then replicate('0|',@vLimit) else @pString0 end
		,	@pString1 = case @pString1 when '' then replicate('0|',@vLimit) else @pString1 end
		,	@pString2 = case @pString2 when '' then replicate('0|',@vLimit) else @pString2 end
		,	@pString3 = case @pString3 when '' then replicate('0|',@vLimit) else @pString3 end
		,	@pString4 = case @pString4 when '' then replicate('0|',@vLimit) else @pString4 end
		,	@pString5 = case @pString5 when '' then replicate('0|',@vLimit) else @pString5 end
		,	@pString6 = case @pString6 when '' then replicate('0|',@vLimit) else @pString6 end
		,	@pString7 = case @pString7 when '' then replicate('0|',@vLimit) else @pString7 end
		,	@pString8 = case @pString8 when '' then replicate('0|',@vLimit) else @pString8 end
		,	@pString9 = case @pString9 when '' then replicate('0|',@vLimit) else @pString9 end

	while @vLimit >= @vStart
	begin
		select	@vStr0 = 'N'''+ substring(@pString0,0,charindex('|',@pString0)) +''','
			,	@vStr1 = 'N'''+ substring(@pString1,0,charindex('|',@pString1)) +''','
			,	@vStr2 = 'N'''+ substring(@pString2,0,charindex('|',@pString2)) +''','
			,	@vStr3 = 'N'''+ substring(@pString3,0,charindex('|',@pString3)) +''','
			,	@vStr4 = 'N'''+ substring(@pString4,0,charindex('|',@pString4)) +''','
			,	@vStr5 = 'N'''+ substring(@pString5,0,charindex('|',@pString5)) +''','
			,	@vStr6 = 'N'''+ substring(@pString6,0,charindex('|',@pString6)) +''','
			,	@vStr7 = 'N'''+ substring(@pString7,0,charindex('|',@pString7)) +''','
			,	@vStr8 = 'N'''+ substring(@pString8,0,charindex('|',@pString8)) +''','
			,	@vStr9 = 'N'''+ substring(@pString9,0,charindex('|',@pString9)) +''''
		select	@pString0 = substring(@pString0,charindex('|',@pString0)+1,999999999)
			,	@pString1 = substring(@pString1,charindex('|',@pString1)+1,999999999)
			,	@pString2 = substring(@pString2,charindex('|',@pString2)+1,999999999)
			,	@pString3 = substring(@pString3,charindex('|',@pString3)+1,999999999)
			,	@pString4 = substring(@pString4,charindex('|',@pString4)+1,999999999)
			,	@pString5 = substring(@pString5,charindex('|',@pString5)+1,999999999)
			,	@pString6 = substring(@pString6,charindex('|',@pString6)+1,999999999)
			,	@pString7 = substring(@pString7,charindex('|',@pString7)+1,999999999)
			,	@pString8 = substring(@pString8,charindex('|',@pString8)+1,999999999)
			,	@pString9 = substring(@pString9,charindex('|',@pString9)+1,999999999)

		select	@vSQL	+= ',('+ @vStr0 + @vStr1 + @vStr2 + @vStr3 + @vStr4 + @vStr5 + @vStr6 + @vStr7 + @vStr8 + @vStr9 +')'+ char(10)
			,	@vStart	+= 1
	end


	set @vLimit = 9
	if @vLimit >= @vSeqNo
	begin
		while @vLimit >= @vSeqNo
		begin
			select	@vTmp1	+= ',N''0'''
				,	@vTmp2	+= ',c'+ rtrim(@vSeqNo)
				,	@vSeqNo	+= 1
		end
		set @vTmp1 += ')'

		select	@vSQL	= replace(@vSQL,@vTmp1,')')
			,	@vCols	= replace(@vCols,@vTmp2,'')
	end


	set @vSQL = '
		select	*
		from	(
			values '+ stuff(@vSQL,1,1,'') +'
		) as a ('+ @vCols +')
		option (recompile)'
--	print @vSQL
	exec sp_executesql @vSQL with recompile


	return 0
end
/*
set statistics io on
use SiteManager
exec dbo.uspGetArray2Table
 @pString0 = '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|'
,@pString1 = '1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|'
,@pString2 = '10003521|10007451|10004431|10006370|10001257|10007596|10005788|10005601|10005444|10001725|10003020|10002741|10004474|10004099|10000185|10004234|10003452|10001167|10004403|10001934|10001543|10002406|10003641|10007008|10001355|10007402|'
,@pString3 = '0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|0|1|2|3|4|5|6|7|8|9|10|'
,@pString4 = '7|8|9|0|3|4|5|6|2|100|100|100|100|100|100|1|1|1|1|1|101|101|101|101|101|101|'
,@pString5 = '1|1|0|0|4|0|0|2|3|4|3|2|1|4|4|0|3|4|0|2|1|0|3|3|0|1|'
,@pString6 = '65|52|50|50|40|43|51|47|49|55|57|51|49|56|48|64|40|41|40|51|42|40|40|40|40|40|'
,@pString7 = ''
,@pString8 = ''
,@pString9 = ''
*/
go

use SiteManager
go
if object_id('dbo.uspSetNewErrorLog') is null
	exec ('create procedure dbo.uspSetNewErrorLog as select 1')
--	drop procedure dbo.uspSetNewErrorLog
go
/******************************************************************************
	Name		: dbo.uspSetNewErrorLog
	Description	: 에러로그 저장 (TRY CATCH 에서 실행되며 error_number()를 저장)
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: 활성화 가능한 매장수 초과

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2014-09-23	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetNewErrorLog
(	@oErrorNo		int	output
,	@pPrintMsg		bit = 0

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vDataBase		nvarchar(128)	= db_name()
		,	@vProcedure		nvarchar(128)	= error_procedure()
		,	@vAuthName		sysname			= current_user
		,	@vLoginName		sysname			= original_login()
		,	@vHostName		nvarchar(128)	= host_name()
		,	@vSeverity		int				= error_severity()
		,	@vErrorState	int				= error_state()
		,	@vErrorNo		int				= error_number()
		,	@vErrorLine		int				= error_line()
		,	@vErrorMessage	nvarchar(max)	= error_message()
		,	@vGetDate		datetime		= getdate()
		,	@vLogNo			int				= next value for dbo.sErrorNo;

	insert into dbo.tSpErrorLog
		(	cLogs
		,	cDataBase
		,	cProcedure
		,	cAuther
		,	cLoginName
		,	cHostName
		,	cErrorNo
		,	cUserError
		,	cSeverity
		,	cState
		,	cLineNo
		,	cErrorMessage
		,	cCreateTime
		)
	values
		(	@vLogNo
		,	@vDataBase
		,	@vProcedure
		,	@vAuthName
		,	@vLoginName
		,	@vHostName
		,	@vErrorNo
		,	@oErrorNo
		,	@vSeverity
		,	@vErrorState
		,	@vErrorLine
		,	@vErrorMessage
		,	@vGetDate
		);

	-- print error information
	if @pPrintMsg = 1
	begin
		print	'error number : '+ rtrim(isnull(@vErrorNo,0))
			+	', severity : '+ rtrim(isnull(@vSeverity,0))
			+	', state : '+ rtrim(isnull(@vErrorState,0))
			+	', procedure : '+ isnull(@vProcedure,'-')
			+	', line number : '+ rtrim(isnull(@vErrorLine,0))

		print @vErrorMessage;
	end


	return @oErrorNo
end
/*
set statistics io on
use SiteManager
declare
 @sp int
,@rt int = -10
exec @sp = dbo.uspSetNewErrorLog
 @oErrorNo = @rt output
,@pPrintMsg = 0

print @sp
print @rt
*/
go

