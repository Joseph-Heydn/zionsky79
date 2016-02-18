use SiteManager
go
if object_id('dbo.KWT003_SG_WS_GAME_TABLE') is not null
begin
	print N'dbo.KWT003_SG_WS_GAME_TABLE 테이블이 존재 합니다.'
	goto KWT003_SG_WS_GAME_TABLE
	/**
		truncate table dbo.KWT003_SG_WS_GAME_TABLE
		drop table dbo.KWT003_SG_WS_GAME_TABLE
	**/
end

create table dbo.KWT003_SG_WS_GAME_TABLE
(	cTableNo		int				not null	-- table manage no
,	cGameNo			int				not null
,	cDatabase		varchar(20)		not null
,	cTableId		int				not null	-- object_id
,	cTableName		varchar(50)		not null	-- object_name
,	cTableText		nvarchar(16)	not null	-- table 설명
,	cIsUsed			bit				not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT003_SG_WS_GAME_TABLE drop constraint PK_KWT003_SG_WS_GAME_TABLE_01
alter table dbo.KWT003_SG_WS_GAME_TABLE
add constraint PK_KWT003_SG_WS_GAME_TABLE_01
primary key clustered
(	cTableNo
)

-- drop index KWT003_SG_WS_GAME_TABLE.IX_KWT003_SG_WS_GAME_TABLE_02
create nonclustered index IX_KWT003_SG_WS_GAME_TABLE_02
on	dbo.KWT003_SG_WS_GAME_TABLE
(	cGameNo
,	cDatabase
,	cTableId
)

KWT003_SG_WS_GAME_TABLE:
go

