use SiteManager
go
if object_id('dbo.KWT003_SG_WS_EVENT_DUNGEON') is not null
begin
	print N'dbo.KWT003_SG_WS_EVENT_DUNGEON 테이블이 존재 합니다.'
	goto KWT003_SG_WS_EVENT_DUNGEON
	/**
		truncate table dbo.KWT003_SG_WS_EVENT_DUNGEON
		drop table dbo.KWT003_SG_WS_EVENT_DUNGEON
	**/
end

create table dbo.KWT003_SG_WS_EVENT_DUNGEON
(	cEventNo	tinyint			not null
,	cEventName	nvarchar(16)	not null
,	cCreateTime	datetime		not null
)

KWT003_SG_WS_EVENT_DUNGEON:
go

