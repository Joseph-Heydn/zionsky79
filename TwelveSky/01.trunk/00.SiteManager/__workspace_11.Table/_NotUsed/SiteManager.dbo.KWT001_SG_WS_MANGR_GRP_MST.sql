use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MANGR_GRP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_MANGR_GRP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MANGR_GRP_MST
	/**
		truncate table dbo.KWT001_SG_WS_MANGR_GRP_MST
		drop table dbo.KWT001_SG_WS_MANGR_GRP_MST
	**/
end

create table dbo.KWT001_SG_WS_MANGR_GRP_MST
(	auth_grp_no		int 		not null	-- 권한 그룹
,	admin_no		int			not null	-- 그룹에 속한 유저 번호
,	ipt_time		datetime		null
)

-- alter table dbo.KWT001_SG_WS_MANGR_GRP_MST drop constraint PK_KWT001_SG_WS_MANGR_GRP_MST_01
alter table dbo.KWT001_SG_WS_MANGR_GRP_MST
add constraint PK_KWT001_SG_WS_MANGR_GRP_MST_01
primary key clustered
(	auth_grp_no
,	admin_no
)

-- drop index KWT001_SG_WS_MANGR_GRP_MST.IX_KWT001_SG_WS_MANGR_GRP_MST_02
create unique nonclustered index IX_KWT001_SG_WS_MANGR_GRP_MST_02
ON	dbo.KWT001_SG_WS_MANGR_GRP_MST
(	admin_no
)

truncate table dbo.KWT001_SG_WS_MANGR_GRP_MST
insert into dbo.KWT001_SG_WS_MANGR_GRP_MST
values (2001002,100000001,getdate())

KWT001_SG_WS_MANGR_GRP_MST:
go

