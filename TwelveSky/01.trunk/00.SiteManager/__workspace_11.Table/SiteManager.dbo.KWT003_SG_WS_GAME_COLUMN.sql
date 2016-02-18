use SiteManager
go
if object_id('dbo.KWT003_SG_WS_GAME_COLUMN') is not null
begin
	print N'dbo.KWT003_SG_WS_GAME_COLUMN 테이블이 존재 합니다.'
	goto KWT003_SG_WS_GAME_COLUMN
	/**
		truncate table dbo.KWT003_SG_WS_GAME_COLUMN
		drop table dbo.KWT003_SG_WS_GAME_COLUMN
	**/
end

create table dbo.KWT003_SG_WS_GAME_COLUMN
(	cTableNo		int				not null	-- table manage no
,	cColumnNo		int				not null	-- column_id
,	cColumnText		nvarchar(16)		null	-- column 설명
--,	cFilterKey		tinyint			not null	-- 조건 (1:=, 2:<, 3:<=, 4:>, 5:>=, 6:between)
,	cVitals			bit				not null	-- 필수 여부
,	cIsUsed			bit				not null	-- 사용 여부
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT003_SG_WS_GAME_COLUMN drop constraint PK_KWT003_SG_WS_GAME_COLUMN_01
alter table dbo.KWT003_SG_WS_GAME_COLUMN
add constraint PK_KWT003_SG_WS_GAME_COLUMN_01
primary key clustered
(	cTableNo
,	cColumnNo
)

KWT003_SG_WS_GAME_COLUMN:
go

