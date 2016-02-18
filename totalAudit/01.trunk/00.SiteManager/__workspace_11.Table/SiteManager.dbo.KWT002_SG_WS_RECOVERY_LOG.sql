use SiteManager
go
if object_id('dbo.KWT002_SG_WS_RECOVERY_LOG') is not null
begin
	print N'dbo.KWT002_SG_WS_RECOVERY_LOG 테이블이 존재 합니다.'
	goto KWT002_SG_WS_RECOVERY_LOG
	/**
		alter sequence dbo.sRecoreryLog restart with 1
		truncate table dbo.KWT002_SG_WS_RECOVERY_LOG
		drop table dbo.KWT002_SG_WS_RECOVERY_LOG
	**/
end

create table dbo.KWT002_SG_WS_RECOVERY_LOG
(	cLogs			bigint			not null
,	cWorkDate		int				not null
,	cServerNo		tinyint			not null
,	cPlayerNo		bigint			not null
,	cNickName		nvarchar(16)	not null
,	cPublisher		tinyint			not null
,	cAction			smallint		not null
,	cCreateNo		tinyint			not null
,	cDeleteNo		tinyint			not null
,	cObjectNo		bigint			not null
,	cObjectKey		smallint		not null
,	cTryCnt			tinyint			not null
,	cAdminNo		int				not null
,	cHostIp			varchar(15)		not null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

/*
cAction
	20010 : 영웅 삭제
	20009 : 영웅 복구
	20019 : 아이템 삭제
	20018 : 아이템 복구
	20018 : 착용 아이템 복구
	20000 : 플레이어 삭제
	20052 : 플레이어 복구
*/

-- alter table dbo.KWT002_SG_WS_RECOVERY_LOG drop constraint PK_KWT002_SG_WS_RECOVERY_LOG_01
alter table dbo.KWT002_SG_WS_RECOVERY_LOG
add constraint PK_KWT002_SG_WS_RECOVERY_LOG_01
primary key clustered
(	cLogs desc
)

-- drop index KWT002_SG_WS_RECOVERY_LOG.IX_KWT002_SG_WS_RECOVERY_LOG_02
create nonclustered index IX_KWT002_SG_WS_RECOVERY_LOG_02
ON	dbo.KWT002_SG_WS_RECOVERY_LOG
(	cPlayerNo
,	cWorkDate
)

alter table dbo.KWT002_SG_WS_RECOVERY_LOG add constraint DF_KWT002_SG_WS_RECOVERY_LOG_01 default(next value for dbo.sRecoreryLog) for cLogs

KWT002_SG_WS_RECOVERY_LOG:
go

