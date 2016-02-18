use SiteManager
go
if object_id('dbo.KWT001_SG_WS_AUTH_GRP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_AUTH_GRP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_AUTH_GRP_MST
	/**
		truncate table dbo.KWT001_SG_WS_AUTH_GRP_MST
		drop table dbo.KWT001_SG_WS_AUTH_GRP_MST
	**/
end

create table dbo.KWT001_SG_WS_AUTH_GRP_MST
(	auth_grp_no		int			not null
,	menu_grp_no		int			not null
,	upt_addr		varchar(15)		null
,	upt_time		datetime		null
,	ipt_time		datetime	not null
)

-- alter table dbo.KWT001_SG_WS_AUTH_GRP_MST drop constraint PK_KWT001_SG_WS_AUTH_GRP_MST_01
alter table dbo.KWT001_SG_WS_AUTH_GRP_MST
add constraint PK_KWT001_SG_WS_AUTH_GRP_MST_01
primary key clustered
(	auth_grp_no
,	menu_grp_no
)

alter table dbo.KWT001_SG_WS_AUTH_GRP_MST add constraint DF_KWT001_SG_WS_AUTH_GRP_MST_01 default(getdate()) for ipt_time

truncate table dbo.KWT001_SG_WS_AUTH_GRP_MST
insert into dbo.KWT001_SG_WS_AUTH_GRP_MST
	(	auth_grp_no
	,	menu_grp_no
	)
values
 (1002002,1001001)
,(1002002,1001002)
,(1002002,1001003)
,(1002002,1001004)
,(1002002,1001005)
,(1002002,1001006)
,(1002002,1001007)

KWT001_SG_WS_AUTH_GRP_MST:
go

