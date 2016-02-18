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
 (1001001,1001000,1,1,0,0,'/app/1001000'	,N'Common'			,N'사이트 관리'	,null)
,(1001002,1002000,1,1,0,0,'/app/1002000'	,N'서버수준 현황'	,N''			,null)
,(1001003,1003000,1,1,0,0,'/app/1003000'	,N'디비수준 현황'	,N''			,null)
,(1001004,1004000,1,1,0,0,'/app/1004000'	,N'DDL 활동 현황'	,N''			,null)
,(1001005,1005000,1,1,0,0,'/app/1005000'	,N'DML 활동 현황'	,N''			,null)

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
 (1001001,1001001,1,1,01,0,'/site/baseCode.aspx?m=1'		,N'사이트 그룹'				,N'메뉴 그룹등록/수정')
,(1001001,1001002,1,1,02,0,'/site/adminGroups.aspx?m=2'		,N'관리자 그룹'				,N'구성원관리, 그룹등록/수정, 그룹 역할 설정')
,(1001001,1001003,1,1,03,0,'/site/adminList.aspx?m=3'		,N'관리자 목록'				,N'관리자 추가/수정/삭제, 그룹할당')
,(1001001,1001004,1,1,04,0,'/site/menuList.aspx?m=4'		,N'메뉴 목록'				,N'메뉴등록/삭제그룹에 매뉴 할당')
,(1001001,1001005,1,1,05,0,'/site/actionLog.aspx?m=5'		,N'관리자 작업내역'			,N'작업 내역 리스트를 조회')
,(1001001,1001006,1,1,06,0,'/site/password.aspx?m=6'		,N'비밀번호 변경'			,N'로그인 한 유저 비밀번호 변경')
,(1001001,1001007,1,1,07,0,'/site/encryptTest.aspx?m=7'		,N'Password Hash'			,N'MD5 테스트 페이지')
,(1001001,1001099,1,0,99,0,'/'								,N'메인페이지'				,N'main page')
-- 서버수준 현황
,(1001002,1002001,1,1,01,0,'/web/server/total.aspx'			,N'전체 감사 현황'			,N'')
,(1001002,1002002,1,1,02,0,'/web/server/instance.aspx'		,N'INSTANCE별 감사 현황'		,N'')
,(1001002,1002003,1,1,03,0,'/web/server/database.aspx'		,N'DB별 감사 현황'			,N'')
,(1001002,1002004,1,1,04,0,'/web/server/authority.aspx'		,N'보안 주체별 감사 현황'		,N'')
-- DB수준 현황
,(1001003,1003001,1,1,01,0,'/web/database/total.aspx'		,N'전체 감사 현황'			,N'')
,(1001003,1003002,1,1,02,0,'/web/database/instance.aspx'	,N'INSTANCE별 감사 현황'		,N'')
,(1001003,1003003,1,1,03,0,'/web/database/database.aspx'	,N'DB별 감사 현황'			,N'')
,(1001003,1003004,1,1,04,0,'/web/database/authority.aspx'	,N'보안 주체별 감사 현황'		,N'')
-- DDL 활동 현황
,(1001004,1004001,1,1,01,0,'/web/define/total.aspx'			,N'전체 감사 현황'			,N'')
,(1001004,1004002,1,1,02,0,'/web/define/instance.aspx'		,N'INSTANCE별 감사 현황'		,N'')
,(1001004,1004003,1,1,03,0,'/web/define/database.aspx'		,N'DB별 감사 현황'			,N'')
,(1001004,1004004,1,1,04,0,'/web/define/authority.aspx'		,N'보안 주체별 감사 현황'		,N'')
-- DML 활동 현황
,(1001005,1005001,1,1,01,0,'/web/manipul/total.aspx'		,N'전체 감사 현황'			,N'')
,(1001005,1005002,1,1,02,0,'/web/manipul/instance.aspx'		,N'INSTANCE별 감사 현황'		,N'')
,(1001005,1005003,1,1,03,0,'/web/manipul/database.aspx'		,N'DB별 감사 현황'			,N'')
,(1001005,1005004,1,1,04,0,'/web/manipul/authority.aspx'	,N'보안 주체별 감사 현황'		,N'')

KWT001_SG_WS_MENU_LIST:
go

