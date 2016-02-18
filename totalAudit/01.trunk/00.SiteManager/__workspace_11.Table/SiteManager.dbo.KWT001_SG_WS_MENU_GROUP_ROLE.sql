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

KWT001_SG_WS_MENU_GROUP_ROLE:
go

