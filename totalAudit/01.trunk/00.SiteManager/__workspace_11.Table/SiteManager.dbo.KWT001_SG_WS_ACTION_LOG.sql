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

