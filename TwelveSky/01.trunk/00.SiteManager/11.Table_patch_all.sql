use SiteManager
go
if object_id('dbo.KWT001_SG_WS_ACTION_LOG') is not null
begin
	print N'dbo.KWT001_SG_WS_ACTION_LOG 테이블이 존재 합니다.'
	goto KWT001_SG_WS_ACTION_LOG
	/**
		alter sequence dbo.sActionLog restart with 1
		truncate table dbo.KWT001_SG_WS_ACTION_LOG
		drop table dbo.KWT001_SG_WS_ACTION_LOG
	**/
end

create table dbo.KWT001_SG_WS_ACTION_LOG
(	cLogs			bigint		not null
,	cWorkDate		int			not null
,	cGameNo			int			not null
,	cAccountNo		int			not null
,	cMenuNo			int			not null
,	cProcedure		varchar(80)	not null
,	cResult			int			not null
,	cHostIp			varchar(15)	not null
,	cCreateTime		datetime	not null
)

-- alter table dbo.KWT001_SG_WS_ACTION_LOG drop constraint PK_KWT001_SG_WS_ACTION_LOG_01
alter table dbo.KWT001_SG_WS_ACTION_LOG
add constraint PK_KWT001_SG_WS_ACTION_LOG_01
primary key clustered
(	cLogs desc
)

-- drop index KWT001_SG_WS_ACTION_LOG.IX_KWT001_SG_WS_ACTION_LOG_02
create nonclustered index IX_KWT001_SG_WS_ACTION_LOG_02
on	dbo.KWT001_SG_WS_ACTION_LOG
(	cAccountNo
,	cMenuNo
,	cWorkDate
)

alter table dbo.KWT001_SG_WS_ACTION_LOG add constraint DF_KWT001_SG_WS_ACTION_LOG_01 default(next value for dbo.sActionLog) for cLogs

KWT001_SG_WS_ACTION_LOG:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_AUTH_GROUP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_AUTH_GROUP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_AUTH_GROUP_MST
	/**
		truncate table dbo.KWT001_SG_WS_AUTH_GROUP_MST
		drop table dbo.KWT001_SG_WS_AUTH_GROUP_MST
	**/
end

create table dbo.KWT001_SG_WS_AUTH_GROUP_MST
(	cTopGroup		int			not null
,	cSubGroup		int			not null
,	cHostIp			varchar(15)		null
,	cModifyTime		datetime		null
,	cCreateTime		datetime	not null
)

-- alter table dbo.KWT001_SG_WS_AUTH_GROUP_MST drop constraint PK_KWT001_SG_WS_AUTH_GROUP_MST_01
alter table dbo.KWT001_SG_WS_AUTH_GROUP_MST
add constraint PK_KWT001_SG_WS_AUTH_GROUP_MST_01
primary key clustered
(	cTopGroup
,	cSubGroup
)

alter table dbo.KWT001_SG_WS_AUTH_GROUP_MST add constraint DF_KWT001_SG_WS_AUTH_GROUP_MST_01 default(getdate()) for cCreateTime

truncate table dbo.KWT001_SG_WS_AUTH_GROUP_MST
insert into dbo.KWT001_SG_WS_AUTH_GROUP_MST
	(	cTopGroup
	,	cSubGroup
	)
values
 (1002002,1001001)
,(1002002,1001002)
,(1002002,1001003)
,(1002002,1001004)
,(1002002,1001005)
,(1002002,1001006)
,(1002002,1001007)

KWT001_SG_WS_AUTH_GROUP_MST:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_COMM_GROUP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_COMM_GROUP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_COMM_GROUP_MST
	/**
		truncate table dbo.KWT001_SG_WS_COMM_GROUP_MST
		drop table dbo.KWT001_SG_WS_COMM_GROUP_MST
	**/
end

create table dbo.KWT001_SG_WS_COMM_GROUP_MST
(	cSiteGroup		smallint		not null	-- 전체 그룹번호
,	cCommGroup		int				not null	-- 그룹내 그룹번호
,	cCommName		nvarchar(20)	not null	-- 그룹 이름
,	cOrderBy		tinyint			not null	-- 정렬 순서
,	cIsUsed			bit				not null	-- 사용 여부
,	cIsView			bit				not null	-- 노출 여부
,	cHostIp			varchar(15)			null	-- 변경한 ip
,	cNoteText		nvarchar(50)		null	-- 설명
,	cModifyTime		datetime			null	-- 변경 시간
,	cCreateTime		datetime		not null	-- 생성 시간
)

-- alter table dbo.KWT001_SG_WS_COMM_GROUP_MST drop constraint PK_KWT001_SG_WS_COMM_GROUP_MST_01
alter table dbo.KWT001_SG_WS_COMM_GROUP_MST
add constraint PK_KWT001_SG_WS_COMM_GROUP_MST_01
primary key clustered
(	cSiteGroup
,	cCommGroup
)

-- drop index KWT001_SG_WS_COMM_GROUP_MST.IX_KWT001_SG_WS_COMM_GROUP_MST_02
create unique nonclustered index IX_KWT001_SG_WS_COMM_GROUP_MST_02
on	dbo.KWT001_SG_WS_COMM_GROUP_MST
(	cSiteGroup
,	cCommGroup
)
include
(	cOrderBy
,	cIsUsed
,	cCommName
)

alter table dbo.KWT001_SG_WS_COMM_GROUP_MST add constraint DF_KWT001_SG_WS_COMM_GROUP_MST_01 default(1) for cIsView
alter table dbo.KWT001_SG_WS_COMM_GROUP_MST add constraint DF_KWT001_SG_WS_COMM_GROUP_MST_02 default(getdate()) for cCreateTime


truncate table dbo.KWT001_SG_WS_COMM_GROUP_MST
insert into dbo.KWT001_SG_WS_COMM_GROUP_MST
	(	cSiteGroup
	,	cCommGroup
	,	cOrderBy
	,	cIsUsed
	,	cCommName
	,	cNoteText
	)
values
-- 관리웹 메뉴
 (1001,1001001,01,1,N'Common'		,N'사이트 관리')
,(1001,1001002,02,1,N'Main'			,N'메인 화면 켄텐츠 관리')
,(1001,1001003,03,1,N'News'			,N'공지사항과 같은 읽기전용 게시판')
,(1001,1001004,04,1,N'Game Guide'	,N'각 게임에 대한 소개, 가이드 게시판')
,(1001,1001005,05,1,N'Community'	,N'일반 공개성 게시판')
,(1001,1001006,06,1,N'Media'		,N'영상, 포토 게시판')
,(1001,1001007,07,1,N'Shop'			,N'아이템 판매 게시판')
,(1001,1001008,08,1,N'Support'		,N'유저 문의 게시판')
,(1001,1001009,09,1,N'Policy'		,N'정책 & 이용약관')
,(1001,1001010,10,1,N'User'			,N'유저 정보 조회')

-- 권한 그룹
,(2001,2001001,99,1,N'Default'		,N'기본 그룹이며 권한은 없다. 로그인만 가능하다.')
,(2001,2001002,01,1,N'Administrator',N'통합관리 개발자. 모든 페이지에 대한 권한이 있다.')
,(2001,2001003,02,1,N'Power User'	,N'개발자를 위한 그룹으로 일부 권한이 있다.')
,(2001,2001004,03,1,N'C/S Master'	,N'C/S 그룹장의 권한으로 팀원에게 권한을 부여할 수 있다.')
,(2001,2001005,04,1,N'C/S User'		,N'상담원 그룹으로 CS업무를 하기위해 필요한 권한만 있다.')
,(2001,2001006,05,1,N'Cupon Master'	,N'쿠폰 발급 및 조회 권한이 있다.')
,(2001,2001007,06,1,N'Event Master'	,N'이벤트 생성 및 조회 권한이 있다.')
,(2001,2001008,07,1,N'Static Viewer',N'통계를 조회할 수 있는 권한이 있다.')
,(2001,2001009,08,1,N'Web Member'	,N'공식웹 회원 권한 그룹')
,(2001,2001010,09,1,N'Web Guest'	,N'공식웹 일반 권한 그룹')

-- 부서 그룹
,(3001,3001001,1,1,N'서버'			,N'게임 서버팀')
,(3001,3001002,2,1,N'디비'			,N'디비 서버팀')
,(3001,3001003,3,1,N'클라이언트'		,N'클라이언트팀')
,(3001,3001004,4,1,N'배경'			,N'배경팀')
,(3001,3001005,5,1,N'캐릭터'			,N'캐릭터팀')
,(3001,3001006,6,1,N'C/S'			,N'C/S팀')
,(3001,3001007,7,1,N'기획'			,N'기획팀')
,(3001,3001008,8,1,N'사업'			,N'사업팀')
,(3001,3001009,9,1,N'운영'			,N'운영팀')

KWT001_SG_WS_COMM_GROUP_MST:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MANGR_GROUP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_MANGR_GROUP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MANGR_GROUP_MST
	/**
		truncate table dbo.KWT001_SG_WS_MANGR_GROUP_MST
		drop table dbo.KWT001_SG_WS_MANGR_GROUP_MST
	**/
end

create table dbo.KWT001_SG_WS_MANGR_GROUP_MST
(	cAuthGroup		int 		not null	-- 권한 그룹
,	cAdminNo		int			not null	-- 그룹에 속한 유저 번호
,	cCreateTime		datetime		null
)

-- alter table dbo.KWT001_SG_WS_MANGR_GROUP_MST drop constraint PK_KWT001_SG_WS_MANGR_GROUP_MST_01
alter table dbo.KWT001_SG_WS_MANGR_GROUP_MST
add constraint PK_KWT001_SG_WS_MANGR_GROUP_MST_01
primary key clustered
(	cAuthGroup
,	cAdminNo
)

-- drop index KWT001_SG_WS_MANGR_GROUP_MST.IX_KWT001_SG_WS_MANGR_GROUP_MST_02
create unique nonclustered index IX_KWT001_SG_WS_MANGR_GROUP_MST_02
ON	dbo.KWT001_SG_WS_MANGR_GROUP_MST
(	cAdminNo
)

truncate table dbo.KWT001_SG_WS_MANGR_GROUP_MST
insert into dbo.KWT001_SG_WS_MANGR_GROUP_MST
values (2001002,100000001,getdate())

KWT001_SG_WS_MANGR_GROUP_MST:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MANGR_LIST') is not null
begin
	print N'dbo.KWT001_SG_WS_MANGR_LIST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MANGR_LIST
	/**
		alter sequence dbo.sAdminNo restart with 100000001
		truncate table dbo.KWT001_SG_WS_MANGR_LIST
		drop table dbo.KWT001_SG_WS_MANGR_LIST
	**/
end

create table dbo.KWT001_SG_WS_MANGR_LIST
(	cAdminNo		int				not null	-- 유저 번호
,	cAdminId		varchar(20)		not null	-- 아이디
,	cPassword		char(32)		not null	-- 비번
,	cAdminName		nvarchar(20)	not null	-- 이름
,	cDeptNo			int				not null	-- 부서 그룹
,	cIsUsed			bit					null	-- 사용여부
,	cNoteText		nvarchar(30)		null	-- 설명
,	cHostIp			varchar(15)			null	-- 변경 ip
,	cLoginTime		datetime			null	-- 접속시간
,	cModifyTime		datetime			null	-- 변경 시간
,	cCreateTime		datetime		not null	-- 생성 시간
)

-- alter table dbo.KWT001_SG_WS_MANGR_LIST drop constraint PK_KWT001_SG_WS_MANGR_LIST_01
alter table dbo.KWT001_SG_WS_MANGR_LIST
add constraint PK_KWT001_SG_WS_MANGR_LIST_01
primary key clustered
(	cAdminNo desc
)

-- drop index KWT001_SG_WS_MANGR_LIST.IX_KWT001_SG_WS_MANGR_LIST_02
create unique nonclustered index IX_KWT001_SG_WS_MANGR_LIST_02
on	dbo.KWT001_SG_WS_MANGR_LIST
(	cAdminName
,	cAdminId
)
include
(	cIsUsed
,	cDeptNo
,	cNoteText
)

-- drop index KWT001_SG_WS_MANGR_LIST.IX_KWT001_SG_WS_MANGR_LIST_03
create unique nonclustered index IX_KWT001_SG_WS_MANGR_LIST_03
on	dbo.KWT001_SG_WS_MANGR_LIST
(	cAdminName
)

-- drop index KWT001_SG_WS_MANGR_LIST.IX_KWT001_SG_WS_MANGR_LIST_04
create unique nonclustered index IX_KWT001_SG_WS_MANGR_LIST_04
on	dbo.KWT001_SG_WS_MANGR_LIST
(	cAdminId
)

alter table dbo.KWT001_SG_WS_MANGR_LIST add constraint DF_KWT001_SG_WS_MANGR_LIST_01 default(next value for dbo.sAdminNo) for cAdminNo

truncate table dbo.KWT001_SG_WS_MANGR_LIST
insert into dbo.KWT001_SG_WS_MANGR_LIST
values (next value for dbo.sAdminNo,'likethis79','efb50b1cf32d8db47ff91573d64f1984',N'진훈식',3001002,1,'',null,'',null,getdate())

grant select on dbo.KWT001_SG_WS_MANGR_LIST to [opwebuser]

KWT001_SG_WS_MANGR_LIST:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MANGR_LOG') is not null
begin
	print N'dbo.KWT001_SG_WS_MANGR_LOG 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MANGR_LOG
	/**
		alter sequence dbo.sManagerLog restart with 1
		truncate table dbo.KWT001_SG_WS_MANGR_LOG
		drop table dbo.KWT001_SG_WS_MANGR_LOG
	**/
end

create table dbo.KWT001_SG_WS_MANGR_LOG
(	cLogs			bigint		not null
,	cWorkDate		int			not null
,	cGameNo			int			not null
,	cAdminNo		int			not null
,	cMenuNo			int			not null
,	cHttpGet		varchar(max)	null
,	cHttpPost		varchar(max)	null
,	cReferer		varchar(max)	null
,	cHostIp			varchar(15)		null
,	cCreateTime		datetime	not null
)

-- alter table dbo.KWT001_SG_WS_MANGR_LOG drop constraint PK_KWT001_SG_WS_MANGR_LOG_01
alter table dbo.KWT001_SG_WS_MANGR_LOG
add constraint PK_KWT001_SG_WS_MANGR_LOG_01
primary key clustered
(	cLogs desc
)

-- drop index KWT001_SG_WS_MANGR_LOG.IX_KWT001_SG_WS_MANGR_LOG_02
create nonclustered index IX_KWT001_SG_WS_MANGR_LOG_02
on	dbo.KWT001_SG_WS_MANGR_LOG
(	cAdminNo
,	cMenuNo
,	cWorkDate
)

alter table dbo.KWT001_SG_WS_MANGR_LOG add constraint DF_KWT001_SG_WS_MANGR_LOG_01 default(next value for dbo.sManagerLog) for cLogs

KWT001_SG_WS_MANGR_LOG:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MENU_GROUP_ROLE') is not null
begin
	print N'dbo.KWT001_SG_WS_MENU_GROUP_ROLE 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MENU_GROUP_ROLE
	/**
		truncate table dbo.KWT001_SG_WS_MENU_GROUP_ROLE
		drop table dbo.KWT001_SG_WS_MENU_GROUP_ROLE
	**/
end

create table dbo.KWT001_SG_WS_MENU_GROUP_ROLE
(	cSiteGroup		smallint	not null
,	cAuthGroup		int			not null
,	cMenuGroup		int			not null
,	cMenuNo			int			not null
,	cIsRead			bit			not null
,	cIsWrite		bit			not null
,	cUpdaterNo		int			not null
,	cCreateTime		datetime	not null
)

-- alter table dbo.KWT001_SG_WS_MENU_GROUP_ROLE drop constraint PK_KWT001_SG_WS_MENU_GROUP_ROLE_01
alter table dbo.KWT001_SG_WS_MENU_GROUP_ROLE
add constraint PK_KWT001_SG_WS_MENU_GROUP_ROLE_01
primary key clustered
(	cAuthGroup
,	cMenuNo
)

-- drop index KWT001_SG_WS_MENU_GROUP_ROLE.IX_KWT001_SG_WS_MENU_GROUP_ROLE_02
create unique nonclustered index IX_KWT001_SG_WS_MENU_GROUP_ROLE_02
on	dbo.KWT001_SG_WS_MENU_GROUP_ROLE
(	cAuthGroup
,	cMenuNo
)
include
(	cSiteGroup
,	cMenuGroup
)


truncate table dbo.KWT001_SG_WS_MENU_GROUP_ROLE
insert into dbo.KWT001_SG_WS_MENU_GROUP_ROLE
values
 (1001,2001002,1001001,1001000,1,0,100000001,getdate())
,(1001,2001002,1001001,1001001,1,1,100000001,getdate())
,(1001,2001002,1001001,1001002,1,1,100000001,getdate())
,(1001,2001002,1001001,1001003,1,1,100000001,getdate())
,(1001,2001002,1001001,1001004,1,1,100000001,getdate())
,(1001,2001002,1001001,1001005,1,1,100000001,getdate())
,(1001,2001002,1001001,1001006,1,1,100000001,getdate())
,(1001,2001002,1001001,1001007,1,1,100000001,getdate())
,(1001,2001002,1001001,1001099,1,1,100000001,getdate())
-- Site Main manager
,(1001,2001002,1001002,1002000,1,0,100000001,getdate())
,(1001,2001002,1001002,1002001,1,1,100000001,getdate())
,(1001,2001002,1001002,1002002,1,1,100000001,getdate())
,(1001,2001002,1001002,1002003,1,1,100000001,getdate())
-- News
,(1001,2001002,1001003,1003000,1,0,100000001,getdate())
,(1001,2001002,1001003,1003001,1,1,100000001,getdate())
,(1001,2001002,1001003,1003002,1,1,100000001,getdate())
-- Guide
,(1001,2001002,1001004,1004000,1,0,100000001,getdate())
,(1001,2001002,1001004,1004001,1,1,100000001,getdate())
,(1001,2001002,1001004,1004002,1,1,100000001,getdate())
,(1001,2001002,1001004,1004003,1,1,100000001,getdate())
,(1001,2001002,1001004,1004004,1,1,100000001,getdate())
,(1001,2001002,1001004,1004005,1,1,100000001,getdate())
,(1001,2001002,1001004,1004006,1,1,100000001,getdate())
,(1001,2001002,1001004,1004007,1,1,100000001,getdate())
,(1001,2001002,1001004,1004008,1,1,100000001,getdate())
,(1001,2001002,1001004,1004009,1,1,100000001,getdate())
,(1001,2001002,1001004,1004010,1,1,100000001,getdate())
,(1001,2001002,1001004,1004011,1,1,100000001,getdate())
,(1001,2001002,1001004,1004012,1,1,100000001,getdate())
,(1001,2001002,1001004,1004013,1,1,100000001,getdate())
,(1001,2001002,1001004,1004014,1,1,100000001,getdate())
,(1001,2001002,1001004,1004015,1,1,100000001,getdate())
,(1001,2001002,1001004,1004016,1,1,100000001,getdate())
,(1001,2001002,1001004,1004017,1,1,100000001,getdate())
,(1001,2001002,1001004,1004018,1,1,100000001,getdate())
,(1001,2001002,1001004,1004019,1,1,100000001,getdate())
-- Community
,(1001,2001002,1001005,1005000,1,0,100000001,getdate())
,(1001,2001002,1001005,1005001,1,1,100000001,getdate())
,(1001,2001002,1001005,1005002,1,1,100000001,getdate())
,(1001,2001002,1001005,1005003,1,1,100000001,getdate())
,(1001,2001002,1001005,1005004,1,1,100000001,getdate())
-- Media
,(1001,2001002,1001006,1006000,1,0,100000001,getdate())
,(1001,2001002,1001006,1006001,1,1,100000001,getdate())
,(1001,2001002,1001006,1006002,1,1,100000001,getdate())
,(1001,2001002,1001006,1006003,1,1,100000001,getdate())
-- Shop
,(1001,2001002,1001007,1007000,1,0,100000001,getdate())
,(1001,2001002,1001007,1007001,1,1,100000001,getdate())
,(1001,2001002,1001007,1007002,1,1,100000001,getdate())
,(1001,2001002,1001007,1007003,1,1,100000001,getdate())
,(1001,2001002,1001007,1007004,1,1,100000001,getdate())
,(1001,2001002,1001007,1007005,1,1,100000001,getdate())
,(1001,2001002,1001007,1007006,1,0,100000001,getdate())
,(1001,2001002,1001007,1007007,1,0,100000001,getdate())
,(1001,2001002,1001007,1007008,1,0,100000001,getdate())
,(1001,2001002,1001007,1007009,1,0,100000001,getdate())
,(1001,2001002,1001007,1007010,1,0,100000001,getdate())
-- My page
,(1001,2001002,1001008,1008000,1,0,100000001,getdate())
,(1001,2001002,1001008,1008003,1,1,100000001,getdate())
,(1001,2001002,1001008,1008004,1,1,100000001,getdate())
,(1001,2001002,1001008,1008005,1,1,100000001,getdate())
-- Terms & Policy
,(1001,2001002,1001011,1011000,1,0,100000001,getdate())
,(1001,2001002,1001011,1011001,1,1,100000001,getdate())
,(1001,2001002,1001011,1011002,1,1,100000001,getdate())
-- Admin. users
,(1001,2001002,1001012,1012000,1,0,100000001,getdate())
,(1001,2001002,1001012,1012001,1,0,100000001,getdate())
,(1001,2001002,1001012,1012002,1,0,100000001,getdate())

-- Web Member
insert into dbo.KWT001_SG_WS_MENU_GROUP_ROLE
select	cSiteGroup
	,	2001009
	,	cMenuGroup
	,	cMenuNo
	,	cIsRead
	,	cIsWrite
	,	cUpdaterNo
	,	cCreateTime
from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE
where	cMenuGroup between 1001003 and 1001009
	and	cAuthGroup = 2001002

insert into dbo.KWT001_SG_WS_MENU_GROUP_ROLE
values
 (1001,2001009,1001008,1008001,1,0,100000001,getdate())
,(1001,2001009,1001008,1008002,1,0,100000001,getdate())
,(1001,2001009,1001008,1008006,1,0,100000001,getdate())
-- Find Id/Password
,(1001,2001010,1001009,1009001,1,0,100000001,getdate())
,(1001,2001010,1001009,1009002,1,0,100000001,getdate())
-- SignUp
,(1001,2001009,1001010,1010001,1,1,100000001,getdate())
,(1001,2001010,1001010,1010001,1,1,100000001,getdate())


-- Web Guest
insert into dbo.KWT001_SG_WS_MENU_GROUP_ROLE
select	cSiteGroup
	,	2001010
	,	cMenuGroup
	,	cMenuNo
	,	cIsRead
	,	cIsWrite
	,	cUpdaterNo
	,	cCreateTime
from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE
where	cMenuGroup between 1001003 and 1001009
	and cMenuGroup != 1001008
	and	cAuthGroup = 2001002

delete
from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE
where	cMenuNo in (1004001)
	and	cAuthGroup in (2001009,2001010)

delete
from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE
where	cAuthGroup = 2001010
	and	cMenuNo in (1007006,1007007,1007008,1007009,1007010)

KWT001_SG_WS_MENU_GROUP_ROLE:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MENU_LIST') is not null
begin
	print N'dbo.KWT001_SG_WS_MENU_LIST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MENU_LIST
	/**
		truncate table dbo.KWT001_SG_WS_MENU_LIST
		drop table dbo.KWT001_SG_WS_MENU_LIST
	**/
end

create table dbo.KWT001_SG_WS_MENU_LIST
(	cMenuGroup		int				not null
,	cMenuNo			int				not null
,	cMenuName		nvarchar(20)	not null
,	cExecUrl		varchar(120)	not null
,	cImageUrl		varchar(120)		null
,	cNoteText		nvarchar(50)		null
,	cIsUsed			bit				not null
,	cIsView			bit				not null
,	cOrderBy		tinyint			not null
,	cStep			tinyint			not null
,	cHostIp			varchar(15)			null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT001_SG_WS_MENU_LIST drop constraint PK_KWT001_SG_WS_MENU_LIST_01
alter table dbo.KWT001_SG_WS_MENU_LIST
add constraint PK_KWT001_SG_WS_MENU_LIST_01
primary key clustered
(	cMenuGroup
,	cMenuNo
)

-- drop index KWT001_SG_WS_MENU_LIST.IX_KWT001_SG_WS_MENU_LIST_02
create unique nonclustered index IX_KWT001_SG_WS_MENU_LIST_02
on	dbo.KWT001_SG_WS_MENU_LIST
(	cExecUrl
,	cIsUsed
,	cOrderBy
)
/*
-- drop index KWT001_SG_WS_MENU_LIST.IX_KWT001_SG_WS_MENU_LIST_03
create unique nonclustered index IX_KWT001_SG_WS_MENU_LIST_03
on	dbo.KWT001_SG_WS_MENU_LIST
(	cMenuGroup
,	cOrderBy
)
include
(	cIsUsed
,	cIsView
)
*/
alter table dbo.KWT001_SG_WS_MENU_LIST add constraint DF_KWT001_SG_WS_MENU_LIST_01 default(getdate()) for cCreateTime


truncate table dbo.KWT001_SG_WS_MENU_LIST
insert into dbo.KWT001_SG_WS_MENU_LIST
	(	cMenuGroup
	,	cMenuNo
	,	cIsUsed
	,	cIsView
	,	cOrderBy
	,	cStep
	,	cExecUrl
	,	cMenuName
	,	cNoteText
	,	cImageUrl
	)
values
 (1001001,1001000,1,1,0,0,'/app/1001000'							,N'Common'		,N'사이트 관리'				,null)
,(1001002,1002000,1,1,0,0,'/app/1002000'							,N'Main'		,N'메인 화면 켄텐츠 관리'		,null)
,(1001003,1003000,1,1,0,0,'/web/board/list.aspx?m=1000004'			,N'News'		,N'공지사항과 같은 읽기전용'	,'top_navi_01.png')
,(1001004,1004000,1,1,0,0,'/web/board/guide.aspx?m=1000006&w=1'		,N'Game Guide'	,N'게임에 대한 소개, 가이드'	,'top_navi_02.png')
,(1001005,1005000,1,1,0,0,'/web/board/list.aspx?m=1000007'			,N'Community'	,N'일반 공개성 게시판'		,'top_navi_03.png')
,(1001006,1006000,1,1,0,0,'/web/board/list.aspx?m=1000011'			,N'Media'		,N'영상, 포토 게시판'		,'top_navi_04.png')
,(1001007,1007000,1,1,0,0,'/web/board/items.aspx?m=1000014'			,N'Shop'		,N'아이템 소개 및 판매'		,'top_navi_05.png')
,(1001008,1008000,1,0,0,0,'/app/1008000'							,N'My Page'		,N'개인정보 및 1:1문의'		,null)
,(1001009,1009000,1,0,0,0,'/app/1009000'							,N'My Page'		,N'Id/Password 찾기'			,null)
,(1001010,1010000,1,0,0,0,'/app/1010000'							,N'Sign up'		,N'회원 가입'				,null)
,(1001011,1011000,1,0,0,0,'/app/1011000'							,N'Policy'		,N'정책 & 이용약관'			,null)
,(1001012,1012000,1,1,0,0,'/app/1012000'							,N'User'		,N'유저 정보 조회'			,null)

insert into dbo.KWT001_SG_WS_MENU_LIST
	(	cMenuGroup
	,	cMenuNo
	,	cIsUsed
	,	cIsView
	,	cOrderBy
	,	cStep
	,	cExecUrl
	,	cMenuName
	,	cNoteText
	)
values
 (1001001,1001001,1,1,01,0,'/site/baseCode.aspx'					,N'사이트 그룹'			,N'메뉴 그룹등록/수정')
,(1001001,1001002,1,1,02,0,'/site/adminGroups.aspx'					,N'관리자 그룹'			,N'구성원관리, 그룹등록/수정, 그룹 역할 설정')
,(1001001,1001003,1,1,03,0,'/site/adminList.aspx'					,N'관리자 목록'			,N'관리자 추가/수정/삭제, 그룹할당')
,(1001001,1001004,1,1,04,0,'/site/menuList.aspx'					,N'메뉴 목록'			,N'메뉴등록/삭제그룹에 매뉴 할당')
,(1001001,1001005,1,1,05,0,'/site/actionLog.aspx'					,N'관리자 작업내역'		,N'작업 내역 리스트를 조회')
,(1001001,1001006,1,1,06,0,'/site/password.aspx'					,N'비밀번호 변경'		,N'로그인 한 유저 비밀번호 변경')
,(1001001,1001007,1,1,07,0,'/site/encryptTest.aspx'					,N'Password Hash'		,N'MD5 테스트 페이지')
,(1001001,1001099,1,0,99,0,'/'										,N'메인페이지'			,N'main page')
-- Site Main manager
,(1001002,1002001,1,1,01,0,'/web/main/images.aspx?m=1000001'		,N'Main Image'			,N'메인 화면에 노출되는 슬라이드 이미지')
,(1001002,1002002,1,1,02,0,'/web/main/movies.aspx?m=1000002'		,N'Main Movie'			,N'메인 화면에 노출되는 동영상')
,(1001002,1002003,1,1,03,0,'/web/main/banner.aspx?m=1000003'		,N'Main Banner'			,N'메인 화면에 노출되는 좌/우 광고')
-- News
,(1001003,1003001,1,1,01,0,'/web/board/list.aspx?m=1000004'			,N'Announcements'		,N'News -&gt; Announcements')
,(1001003,1003002,1,1,02,0,'/web/board/list.aspx?m=1000005'			,N'Notice'				,N'News -&gt; Notice')
-- Game Guides
,(1001004,1004001,1,1,01,0,'/web/board/list.aspx?m=1000006'			,N'Guides List'			,N'Game Guides list')
,(1001004,1004002,1,1,02,0,'/web/board/guide.aspx?m=1000006&w=1'	,N'Story'				,N'Game Guides -&gt; Story')
,(1001004,1004003,1,1,03,0,'/web/board/guide.aspx?m=1000006&w=2'	,N'Introduction'		,N'Game Guides -&gt; Introduction')
,(1001004,1004004,1,1,04,0,'/web/board/guide.aspx?m=1000006&w=3'	,N'Game Feature'		,N'Game Guides -&gt; Game Feature')
,(1001004,1004005,1,1,05,0,'/web/board/guide.aspx?m=1000006&w=4'	,N'System Requirements'	,N'Game Guides -&gt; System Requirements')
,(1001004,1004006,1,1,06,0,'/web/board/guide.aspx?m=1000006&w=5'	,N'General Questions'	,N'Game Guides -&gt; General Questions')
,(1001004,1004007,1,1,07,0,'/web/board/guide.aspx?m=1000006&w=6'	,N'Getting Started'		,N'Game Guides -&gt; Getting Started')
,(1001004,1004008,1,1,08,0,'/web/board/guide.aspx?m=1000006&w=7'	,N'Class Info'			,N'Game Guides -&gt; Class Info')
,(1001004,1004009,1,1,09,8,'/web/board/guide.aspx?m=1000006&w=7'	,N'Guanyin'				,N'Game Guides -&gt; Class Info -&gt; Guanyin')
,(1001004,1004010,1,1,10,8,'/web/board/guide.aspx?m=1000006&w=8'	,N'Fujin'				,N'Game Guides -&gt; Class Info -&gt; Fujin')
,(1001004,1004011,1,1,11,8,'/web/board/guide.aspx?m=1000006&w=9'	,N'Jinong'				,N'Game Guides -&gt; Class Info -&gt; Jinong')
,(1001004,1004012,1,1,12,8,'/web/board/guide.aspx?m=1000006&w=10'	,N'Nangin'				,N'Game Guides -&gt; Class Info -&gt; Nangin')
,(1001004,1004013,1,1,13,0,'/web/board/guide.aspx?m=1000006&w=11'	,N'Game Play'			,N'Game Guides -&gt; Game Play')
,(1001004,1004014,1,1,14,0,'/web/board/guide.aspx?m=1000006&w=12'	,N'Pet Information'		,N'Game Guides -&gt; Pet Information')
,(1001004,1004015,1,1,15,0,'/web/board/guide.aspx?m=1000006&w=13'	,N'Items'				,N'Game Guides -&gt; Items')
,(1001004,1004016,1,1,16,0,'/web/board/guide.aspx?m=1000006&w=14'	,N'PvP Combat'			,N'Game Guides -&gt; PvP Combat')
,(1001004,1004017,1,1,17,0,'/web/board/guide.aspx?m=1000006&w=15'	,N'Player Interaction'	,N'Game Guides -&gt; Player Interaction')
,(1001004,1004018,1,1,18,0,'/web/board/guide.aspx?m=1000006&w=16'	,N'Government'			,N'Game Guides -&gt; Government')
,(1001004,1004019,1,1,19,0,'/web/board/guide.aspx?m=1000006&w=17'	,N'NPCs'				,N'Game Guides -&gt; NPCs')
-- Community
,(1001005,1005001,1,1,01,0,'/web/board/list.aspx?m=1000007'			,N'General Discussion'	,N'Community -&gt; General Discussion')
,(1001005,1005002,1,1,02,0,'/web/board/list.aspx?m=1000008'			,N'Tips / Knowhow'		,N'Community -&gt; Tips / Knowhow')
,(1001005,1005003,1,1,03,0,'/web/board/list.aspx?m=1000009'			,N'Problem Solution'	,N'Community -&gt; Problem Solution')
,(1001005,1005004,1,1,04,0,'/web/board/list.aspx?m=1000010'			,N'Item Trade'			,N'Community -&gt; Item Trade')
-- Media
,(1001006,1006001,1,1,01,0,'/web/board/list.aspx?m=1000011'			,N'Video'				,N'Media -&gt; Video')
,(1001006,1006002,1,1,02,0,'/web/board/list.aspx?m=1000012'			,N'Artwork'				,N'Media -&gt; Artwork')
,(1001006,1006003,1,1,03,0,'/web/board/list.aspx?m=1000013'			,N'Screenshots'			,N'Media -&gt; Screenshots')
-- Shop
,(1001007,1007001,1,1,01,0,'/web/board/items.aspx?m=1000014'		,N'Item List'			,N'Shop -&gt; Item List')
,(1001007,1007002,1,0,02,0,'/web/board/items.aspx?m=1000014'		,N'Upgrading'			,N'Shop -&gt; Item List -&gt; Upgrading')
,(1001007,1007003,1,0,03,0,'/web/board/items.aspx?m=1000015'		,N'Buffs'				,N'Shop -&gt; Item List -&gt; Buffs')
,(1001007,1007004,1,0,04,0,'/web/board/items.aspx?m=1000016'		,N'Vanity'				,N'Shop -&gt; Item List -&gt; Vanity')
,(1001007,1007005,1,0,05,0,'/web/board/items.aspx?m=1000017'		,N'Miscellaeous'		,N'Shop -&gt; Item List -&gt; Miscellaeous')
-- 타사이트로 넘어가는 링크
,(1001007,1007006,1,1,06,1,'fnMoveBill(''/fillUp/payment.aspx'')'	,N'Cash'				,N'Shop -&gt; Cash')
,(1001007,1007007,1,1,07,6,'fnMoveBill(''/fillUp/payment.aspx'')'	,N'Buy Gp coins'		,N'Shop -&gt; Item List -&gt; Upgrading')
,(1001007,1007008,1,1,08,6,'fnMoveBill(''/history/fillUp.aspx'')'	,N'Fill-up history'		,N'Shop -&gt; Item List -&gt; Buffs')
,(1001007,1007009,1,1,09,6,'fnMoveBill(''/history/purchase.aspx'')'	,N'Purchase history'	,N'Shop -&gt; Item List -&gt; Vanity')
,(1001007,1007010,1,1,10,6,'fnMoveBill(''/policy/coins.aspx'')'		,N'Coins policy'		,N'Shop -&gt; Item List -&gt; Miscellaeous')
-- My Page
,(1001008,1008001,1,1,01,0,'/web/privacy/profile.aspx?m=1000018'	,N'Profile'				,N'My Page -&gt; Profile')
,(1001008,1008002,1,1,02,0,'/web/privacy/password.aspx?m=1000019'	,N'Change Password'		,N'My Page -&gt; Change Password')
,(1001008,1008003,1,1,03,0,'/web/privacy/history.aspx?m=1000020'	,N'Support'				,N'My Page -&gt; Support')
,(1001008,1008004,1,1,04,3,'/web/privacy/history.aspx?m=1000020'	,N'My Question'			,N'My Page -&gt; My Question')
,(1001008,1008005,1,1,05,3,'/web/privacy/contatct.aspx?m=1000021'	,N'Contatct Us'			,N'My Page -&gt; Contatct Us')
,(1001008,1008006,1,1,06,0,'/web/privacy/withdraw.aspx?m=1000022'	,N'Deactivate account'	,N'My Page -&gt; Deactivate account')
-- My Page2
,(1001009,1009001,1,1,01,0,'/web/privacy/findId.aspx?m=1000023'		,N'Find Id'				,N'My Page -&gt; Find Id')
,(1001009,1009002,1,1,02,0,'/web/privacy/findPass.aspx?m=1000024'	,N'Find Password'		,N'My Page -&gt; Find Password')
,(1001009,1009003,1,0,03,0,'/web/privacy/findResult.aspx?m=1000023'	,N'Find Id & Password'	,N'My Page -&gt; Find Id & Password')
-- SignUp
,(1001010,1010001,1,1,01,0,'/web/privacy/signUp.aspx?m=1000025'		,N'Sign up'				,N'My Page -&gt; Sign up')
,(1001010,1010002,1,1,02,0,'/web/privacy/signUpOk.aspx?m=1000025'	,N'Sign up'				,N'My Page -&gt; Sign up')
-- Terms & Policy
,(1001011,1011001,1,1,01,0,'/web/policy.aspx?m=1000026&w=18'		,N'Terms of Use'		,N'Home -&gt; Terms of Use')
,(1001011,1011002,1,1,02,0,'/web/policy.aspx?m=1000026&w=19'		,N'Privacy Policy'		,N'Home -&gt; Privacy Policy')
-- Admin. Users
,(1001012,1012001,1,1,01,0,'/web/guest/players.aspx?m=1000018'		,N'User Admin'			,N'User -&gt; User Admin')
,(1001012,1012002,1,1,02,0,'/web/guest/entryStat.aspx?m=1000026'	,N'Signup User Count'	,N'User -&gt; Signup User Count')

KWT001_SG_WS_MENU_LIST:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MENU_NAME') is not null
begin
	print N'dbo.KWT001_SG_WS_MENU_NAME 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MENU_NAME
	/**
		truncate table dbo.KWT001_SG_WS_MENU_NAME
		drop table dbo.KWT001_SG_WS_MENU_NAME
	**/
end

create table dbo.KWT001_SG_WS_MENU_NAME
(	cMenuNo		int				not null
,	cLangNo		tinyint			not null
,	cMenuName	nvarchar(30)	not null
)

-- alter table dbo.KWT001_SG_WS_MENU_NAME drop constraint PK_KWT001_SG_WS_MENU_NAME_01
alter table dbo.KWT001_SG_WS_MENU_NAME
add constraint PK_KWT001_SG_WS_MENU_NAME_01
primary key clustered
(	cMenuNo
,	cLangNo
)


truncate table dbo.KWT001_SG_WS_MENU_NAME
insert into dbo.KWT001_SG_WS_MENU_NAME
values
 (1003001,3,N'Announcements')
,(1003002,3,N'Notice')

,(1004001,3,N'Guides List')
,(1004002,3,N'Story')
,(1004003,3,N'Introduction')
,(1004004,3,N'Game Feature')
,(1004005,3,N'System Requirements')
,(1004006,3,N'General Questions')
,(1004007,3,N'Getting Started')
,(1004008,3,N'Class Info')
,(1004009,3,N'Game Play')
,(1004010,3,N'Pet Information')
,(1004011,3,N'Items')
,(1004012,3,N'PvP Combat')
,(1004013,3,N'Player Interaction')
,(1004014,3,N'Government')
,(1004015,3,N'NPCs')

,(1005001,3,N'General Discussion')
,(1005002,3,N'Tips / Knowhow')
,(1005003,3,N'Problem Solution')
,(1005004,3,N'Item Trade')

,(1006001,3,N'Video')
,(1006002,3,N'Artwork')
,(1006003,3,N'Screenshots')

,(1007001,3,N'Item List')
,(1007002,3,N'Upgrading')
,(1007003,3,N'Buffs')
,(1007004,3,N'Vanity')
,(1007005,3,N'Miscellaeous')
,(1007006,3,N'Coins')
,(1007007,3,N'Buy Gp coins')
,(1007008,3,N'Fill-up history')
,(1007009,3,N'Purchase history')
,(1007010,3,N'Coins policy')

,(1008001,3,N'Profile')
,(1008002,3,N'Change Password')
,(1008003,3,N'My Question')
,(1008004,3,N'Contatct Us')
,(1008005,3,N'Deactivate account')

,(1009001,3,N'Terms of Use')
,(1009002,3,N'Privacy Policy')

KWT001_SG_WS_MENU_NAME:
go

use SiteManager
go
if object_id('dbo.KWT001_SG_WS_SITE_GROUP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_SITE_GROUP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_SITE_GROUP_MST
	/**
		alter sequence dbo.sSiteGroup restart with 1001
		truncate table dbo.KWT001_SG_WS_SITE_GROUP_MST
		drop table dbo.KWT001_SG_WS_SITE_GROUP_MST
	**/
end

create table dbo.KWT001_SG_WS_SITE_GROUP_MST
(	cSiteGroup		int				not null
,	cSiteName		nvarchar(20)	not null
,	cNoteText		nvarchar(50)		null
,	cIsUsed			bit				not null
,	cHostIp			varchar(15)			null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT001_SG_WS_SITE_GROUP_MST drop constraint PK_KWT001_SG_WS_SITE_GROUP_MST_01
alter table dbo.KWT001_SG_WS_SITE_GROUP_MST
add constraint PK_KWT001_SG_WS_SITE_GROUP_MST_01
primary key clustered
(	cSiteGroup
)

alter table dbo.KWT001_SG_WS_SITE_GROUP_MST add constraint DF_KWT001_SG_WS_SITE_GROUP_MST_01 default(getdate()) for cCreateTime

truncate table dbo.KWT001_SG_WS_SITE_GROUP_MST
insert into dbo.KWT001_SG_WS_SITE_GROUP_MST
	(	cSiteGroup
	,	cIsUsed
	,	cSiteName
	,	cNoteText
	)
values
 (1001,1,N'관리웹'		,N'관리웹 메뉴 관리')
,(1002,1,N'테스트웹'		,N'테스트 메뉴 관리')
,(2001,1,N'관리자그룹'	,N'사이트를 이용하는데 필요한 권한 그룹')
,(3001,1,N'부서이름'		,N'유저의 소속 부서 이름')

KWT001_SG_WS_SITE_GROUP_MST:
go

use SiteManager
go
if object_id('dbo.KWT002_SG_WS_GOODS_LOG') is not null
begin
	print N'dbo.KWT002_SG_WS_GOODS_LOG 테이블이 존재 합니다.'
	goto KWT002_SG_WS_GOODS_LOG
	/**
		alter sequence dbo.sGoodsLog restart with 1
		truncate table dbo.KWT002_SG_WS_GOODS_LOG
		drop table dbo.KWT002_SG_WS_GOODS_LOG
	**/
end

create table dbo.KWT002_SG_WS_GOODS_LOG
(	cLogs			bigint			not null
,	cWorkDate		int				not null
,	cServerNo		tinyint			not null
,	cPlayerNo		bigint			not null
,	cNickName		nvarchar(12)	not null
,	cPublisher		bigint			not null
,	cMailNo			bigint			not null
,	cAction			tinyint			not null
,	cValueNew		numeric(19,11)	not null
,	cValueOld		numeric(19,11)	not null
,	cTryCnt			smallint		not null
,	cAdminNo		int				not null
,	cHostIp			varchar(15)		not null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

/*
cAction
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
*/

-- alter table dbo.KWT002_SG_WS_GOODS_LOG drop constraint PK_KWT002_SG_WS_GOODS_LOG_01
alter table dbo.KWT002_SG_WS_GOODS_LOG
add constraint PK_KWT002_SG_WS_GOODS_LOG_01
primary key clustered
(	cLogs desc
)

-- drop index KWT002_SG_WS_GOODS_LOG.IX_KWT002_SG_WS_GOODS_LOG_02
create nonclustered index IX_KWT002_SG_WS_GOODS_LOG_02
ON	dbo.KWT002_SG_WS_GOODS_LOG
(	cPlayerNo
,	cWorkDate
)

-- drop index KWT002_SG_WS_GOODS_LOG.IX_KWT002_SG_WS_GOODS_LOG_02
create nonclustered index IX_KWT002_SG_WS_GOODS_LOG_03
ON	dbo.KWT002_SG_WS_GOODS_LOG
(	cPublisher
,	cWorkDate
)

alter table dbo.KWT002_SG_WS_GOODS_LOG add constraint DF_KWT002_SG_WS_GOODS_LOG_01 default(next value for dbo.sGoodsLog) for cLogs

KWT002_SG_WS_GOODS_LOG:
go

use SiteManager
go
if object_id('dbo.KWT002_SG_WS_RECOVERY_LOG') is not null
begin
	print N'dbo.KWT002_SG_WS_RECOVERY_LOG 테이블이 존재 합니다.'
	goto KWT002_SG_WS_RECOVERY_LOG
	/**
		alter sequence dbo.sRecoreryLog restart with 1
		truncate table dbo.KWT002_SG_WS_RECOVERY_LOG
		drop table dbo.KWT002_SG_WS_RECOVERY_LOG
	**/
end

create table dbo.KWT002_SG_WS_RECOVERY_LOG
(	cLogs			bigint			not null
,	cWorkDate		int				not null
,	cServerNo		tinyint			not null
,	cPlayerNo		bigint			not null
,	cNickName		nvarchar(16)	not null
,	cPublisher		tinyint			not null
,	cAction			smallint		not null
,	cCreateNo		tinyint			not null
,	cDeleteNo		tinyint			not null
,	cObjectNo		bigint			not null
,	cObjectKey		smallint		not null
,	cTryCnt			tinyint			not null
,	cAdminNo		int				not null
,	cHostIp			varchar(15)		not null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

/*
cAction
	20010 : 영웅 삭제
	20009 : 영웅 복구
	20019 : 아이템 삭제
	20018 : 아이템 복구
	20018 : 착용 아이템 복구
	20000 : 플레이어 삭제
	20052 : 플레이어 복구
*/

-- alter table dbo.KWT002_SG_WS_RECOVERY_LOG drop constraint PK_KWT002_SG_WS_RECOVERY_LOG_01
alter table dbo.KWT002_SG_WS_RECOVERY_LOG
add constraint PK_KWT002_SG_WS_RECOVERY_LOG_01
primary key clustered
(	cLogs desc
)

-- drop index KWT002_SG_WS_RECOVERY_LOG.IX_KWT002_SG_WS_RECOVERY_LOG_02
create nonclustered index IX_KWT002_SG_WS_RECOVERY_LOG_02
ON	dbo.KWT002_SG_WS_RECOVERY_LOG
(	cPlayerNo
,	cWorkDate
)

alter table dbo.KWT002_SG_WS_RECOVERY_LOG add constraint DF_KWT002_SG_WS_RECOVERY_LOG_01 default(next value for dbo.sRecoreryLog) for cLogs

KWT002_SG_WS_RECOVERY_LOG:
go

use SiteManager
go
if object_id('dbo.KWT003_SG_WS_GAME_COLUMN') is not null
begin
	print N'dbo.KWT003_SG_WS_GAME_COLUMN 테이블이 존재 합니다.'
	goto KWT003_SG_WS_GAME_COLUMN
	/**
		truncate table dbo.KWT003_SG_WS_GAME_COLUMN
		drop table dbo.KWT003_SG_WS_GAME_COLUMN
	**/
end

create table dbo.KWT003_SG_WS_GAME_COLUMN
(	cTableNo		int				not null	-- table manage no
,	cColumnNo		int				not null	-- column_id
,	cColumnText		nvarchar(16)		null	-- column 설명
--,	cFilterKey		tinyint			not null	-- 조건 (1:=, 2:<, 3:<=, 4:>, 5:>=, 6:between)
,	cVitals			bit				not null	-- 필수 여부
,	cIsUsed			bit				not null	-- 사용 여부
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT003_SG_WS_GAME_COLUMN drop constraint PK_KWT003_SG_WS_GAME_COLUMN_01
alter table dbo.KWT003_SG_WS_GAME_COLUMN
add constraint PK_KWT003_SG_WS_GAME_COLUMN_01
primary key clustered
(	cTableNo
,	cColumnNo
)

KWT003_SG_WS_GAME_COLUMN:
go

use SiteManager
go
if object_id('dbo.KWT003_SG_WS_GAME_TABLE') is not null
begin
	print N'dbo.KWT003_SG_WS_GAME_TABLE 테이블이 존재 합니다.'
	goto KWT003_SG_WS_GAME_TABLE
	/**
		truncate table dbo.KWT003_SG_WS_GAME_TABLE
		drop table dbo.KWT003_SG_WS_GAME_TABLE
	**/
end

create table dbo.KWT003_SG_WS_GAME_TABLE
(	cTableNo		int				not null	-- table manage no
,	cGameNo			int				not null
,	cDatabase		varchar(20)		not null
,	cTableId		int				not null	-- object_id
,	cTableName		varchar(50)		not null	-- object_name
,	cTableText		nvarchar(16)	not null	-- table 설명
,	cIsUsed			bit				not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT003_SG_WS_GAME_TABLE drop constraint PK_KWT003_SG_WS_GAME_TABLE_01
alter table dbo.KWT003_SG_WS_GAME_TABLE
add constraint PK_KWT003_SG_WS_GAME_TABLE_01
primary key clustered
(	cTableNo
)

-- drop index KWT003_SG_WS_GAME_TABLE.IX_KWT003_SG_WS_GAME_TABLE_02
create nonclustered index IX_KWT003_SG_WS_GAME_TABLE_02
on	dbo.KWT003_SG_WS_GAME_TABLE
(	cGameNo
,	cDatabase
,	cTableId
)

KWT003_SG_WS_GAME_TABLE:
go

use SiteManager
go
if object_id('dbo.KWT003_SG_WS_LOG_TABLE') is not null
begin
	print N'dbo.KWT003_SG_WS_LOG_TABLE 테이블이 존재 합니다.'
	goto KWT003_SG_WS_LOG_TABLE
	/**
		truncate table dbo.KWT003_SG_WS_LOG_TABLE
		drop table dbo.KWT003_SG_WS_LOG_TABLE
	**/
end

create table dbo.KWT003_SG_WS_LOG_TABLE
(	cTableNo		int				not null
,	cTableName		varchar(50)		not null
,	cEventName		nvarchar(16)	not null
,	cIsUsed			bit				not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT003_SG_WS_LOG_TABLE drop constraint PK_KWT003_SG_WS_LOG_TABLE_01
alter table dbo.KWT003_SG_WS_LOG_TABLE
add constraint PK_KWT003_SG_WS_LOG_TABLE_01
primary key nonclustered
(	cTableNo
)

truncate table dbo.KWT003_SG_WS_LOG_TABLE
insert into dbo.KWT003_SG_WS_LOG_TABLE
values
 (1000001,'tGameLog_01',N'계정 생성/삭제, 기기정보',1,getdate())
,(1000002,'tGameLog_02',N'계정 생성/삭제, 기기정보',1,getdate())

KWT003_SG_WS_LOG_TABLE:
go

use SiteManager
go
if object_id('dbo.tSpErrorLog') is not null
begin
	print N'dbo.tSpErrorLog 테이블이 존재 합니다.'
	goto tSpErrorLog
	/**
		alter sequence dbo.sErrorNo restart with 1
		truncate table dbo.tSpErrorLog
		drop table dbo.tSpErrorLog
	**/
end

create table dbo.tSpErrorLog
(	cLogs			int				not null
,	cDataBase		varchar(30)		not null
,	cProcedure		varchar(50)			null
,	cAuther			varchar(20)		not null
,	cLoginName		varchar(20)		not null
,	cHostName		varchar(30)		not null
,	cErrorNo		int					null
,	cUserError		int				not null
,	cSeverity		int					null
,	cState			int					null
,	cLineNo			int					null
,	cErrorMessage	nvarchar(max)		null
,	cCreateTime		datetime		not null
)

-- alter table dbo.tSpErrorLog drop constraint PK_tSpErrorLog_01
alter table dbo.tSpErrorLog
add constraint PK_tSpErrorLog_01
primary key clustered
(	cLogs desc
)

-- drop index tSpErrorLog.IX_tSpErrorLog_02
create nonclustered index IX_tSpErrorLog_02
on	dbo.tSpErrorLog
(	cProcedure
)

alter table dbo.tSpErrorLog add constraint DF_tSpErrorLog_01 default(next value for dbo.sErrorNo) for cLogs

tSpErrorLog:
go

