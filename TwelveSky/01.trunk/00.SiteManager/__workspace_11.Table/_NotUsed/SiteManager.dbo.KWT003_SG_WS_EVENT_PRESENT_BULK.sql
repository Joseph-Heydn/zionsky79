use SiteManager
go
if object_id('dbo.KWT003_SG_WS_EVENT_PRESENT_BULK') is not null
begin
	print N'dbo.KWT003_SG_WS_EVENT_PRESENT_BULK 테이블이 존재 합니다.'
	goto KWT003_SG_WS_EVENT_PRESENT_BULK
	/**
		truncate table dbo.KWT003_SG_WS_EVENT_PRESENT_BULK
		drop table dbo.KWT003_SG_WS_EVENT_PRESENT_BULK
	**/
end

create table dbo.KWT003_SG_WS_EVENT_PRESENT_BULK
(	cServerNo		tinyint			not null
,	cEventNo		int				not null identity(-1,-1)
,	cEventName		nvarchar(16)	not null
,	cIsFile			bit				not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT003_SG_WS_EVENT_PRESENT_BULK drop constraint PK_KWT003_SG_WS_EVENT_PRESENT_BULK_01
alter table dbo.KWT003_SG_WS_EVENT_PRESENT_BULK
add constraint PK_KWT003_SG_WS_EVENT_PRESENT_BULK_01
primary key clustered
(	cEventNo
)

KWT003_SG_WS_EVENT_PRESENT_BULK:
go

