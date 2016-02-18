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

