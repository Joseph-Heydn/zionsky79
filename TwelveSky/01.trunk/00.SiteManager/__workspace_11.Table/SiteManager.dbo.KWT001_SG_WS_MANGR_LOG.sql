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

