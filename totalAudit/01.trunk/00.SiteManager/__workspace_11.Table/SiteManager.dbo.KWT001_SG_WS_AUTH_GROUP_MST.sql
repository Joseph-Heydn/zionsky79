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

