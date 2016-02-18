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

