use SiteManager
go
if object_id('dbo.KWT003_SG_WS_LOG_TABLE') is not null
begin
	print N'dbo.KWT003_SG_WS_LOG_TABLE 테이블이 존재 합니다.'
	goto KWT003_SG_WS_LOG_TABLE
	/**
		truncate table dbo.KWT003_SG_WS_LOG_TABLE
		drop table dbo.KWT003_SG_WS_LOG_TABLE
	**/
end

create table dbo.KWT003_SG_WS_LOG_TABLE
(	cTableNo		int				not null
,	cTableName		varchar(50)		not null
,	cEventName		nvarchar(16)	not null
,	cIsUsed			bit				not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT003_SG_WS_LOG_TABLE drop constraint PK_KWT003_SG_WS_LOG_TABLE_01
alter table dbo.KWT003_SG_WS_LOG_TABLE
add constraint PK_KWT003_SG_WS_LOG_TABLE_01
primary key nonclustered
(	cTableNo
)

truncate table dbo.KWT003_SG_WS_LOG_TABLE
insert into dbo.KWT003_SG_WS_LOG_TABLE
values
 (1000001,'tGameLog_01',N'계정 생성/삭제, 기기정보',1,getdate())
,(1000002,'tGameLog_02',N'계정 생성/삭제, 기기정보',1,getdate())

KWT003_SG_WS_LOG_TABLE:
go

