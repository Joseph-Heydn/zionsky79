use SiteManager
go
if object_id('dbo.KWT001_SG_WS_SITE_GRP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_SITE_GRP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_SITE_GRP_MST
	/**
		truncate table dbo.KWT001_SG_WS_SITE_GRP_MST
		drop table dbo.KWT001_SG_WS_SITE_GRP_MST
	**/
end

create table dbo.KWT001_SG_WS_SITE_GRP_MST
(	site_grp_no		int				not null
,	site_grp_nm		nvarchar(20)	not null
,	note_desc		nvarchar(100)		null
,	use_flag		bit				not null
,	upt_addr		varchar(15)			null
,	upt_time		datetime			null
,	ipt_time		datetime		not null
)

-- alter table dbo.KWT001_SG_WS_SITE_GRP_MST drop constraint PK_KWT001_SG_WS_SITE_GRP_MST_01
alter table dbo.KWT001_SG_WS_SITE_GRP_MST
add constraint PK_KWT001_SG_WS_SITE_GRP_MST_01
primary key clustered
(	site_grp_no
)

alter table dbo.KWT001_SG_WS_SITE_GRP_MST add constraint DF_KWT001_SG_WS_SITE_GRP_MST_01 default(getdate()) for ipt_time

truncate table dbo.KWT001_SG_WS_SITE_GRP_MST
insert into dbo.KWT001_SG_WS_SITE_GRP_MST
	(	site_grp_no
	,	use_flag
	,	site_grp_nm
	,	note_desc
	)
values
 (1001,1,N'관리웹'		,N'관리웹 메뉴 관리')
,(1002,1,N'테스트웹'		,N'테스트 메뉴 관리')
,(2001,1,N'관리자그룹'	,N'사이트를 이용하는데 필요한 권한 그룹')
,(3001,1,N'부서이름'		,N'유저의 소속 부서 이름')

KWT001_SG_WS_SITE_GRP_MST:
go

