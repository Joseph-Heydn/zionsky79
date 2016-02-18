use SiteManager
go
if object_id('dbo.KWT003_SG_WS_EVENT_TABLE') is not null
begin
	print N'dbo.KWT003_SG_WS_EVENT_TABLE 테이블이 존재 합니다.'
	goto KWT003_SG_WS_EVENT_TABLE
	/**
		truncate table dbo.KWT003_SG_WS_EVENT_TABLE
		drop table dbo.KWT003_SG_WS_EVENT_TABLE
	**/
end

create table dbo.KWT003_SG_WS_EVENT_TABLE
(	table_no	int				not null
,	table_name	varchar(50)		not null
,	event_name	nvarchar(16)	not null
,	use_flag	bit				not null
,	ipt_time	datetime		not null
)

-- alter table dbo.KWT003_SG_WS_EVENT_TABLE drop constraint PK_KWT003_SG_WS_EVENT_TABLE_01
alter table dbo.KWT003_SG_WS_EVENT_TABLE
add constraint PK_KWT003_SG_WS_EVENT_TABLE_01
primary key nonclustered
(	table_no
)

truncate table dbo.KWT003_SG_WS_EVENT_TABLE
insert into dbo.KWT003_SG_WS_EVENT_TABLE
values
(	1000001
,	'tEventReceivePresent'
,	N'일괄 선물 지급'
,	1
,	getdate()
)

KWT003_SG_WS_EVENT_TABLE:
go

