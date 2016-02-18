use SiteManager
go
if object_id('dbo.KWT003_SG_WS_EVENT_COMBINE') is not null
begin
	print N'dbo.KWT003_SG_WS_EVENT_COMBINE 테이블이 존재 합니다.'
	goto KWT003_SG_WS_EVENT_COMBINE
	/**
		truncate table dbo.KWT003_SG_WS_EVENT_COMBINE
		drop table dbo.KWT003_SG_WS_EVENT_COMBINE
	**/
end

create table dbo.KWT003_SG_WS_EVENT_COMBINE
(	cEventNo		int				not null
,	cEventType		bit				not null
,	cEventName		nvarchar(16)	not null
,	cCreateTime		datetime		not null
)

KWT003_SG_WS_EVENT_COMBINE:
go

/*
insert into dbo.KWT003_SG_WS_EVENT_COMBINE
values(1,0,'성난 심해협곡',getdate())
*/

