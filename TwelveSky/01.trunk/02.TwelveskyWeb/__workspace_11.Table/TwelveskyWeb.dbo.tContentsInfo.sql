use TwelveskyWeb
go
if object_id('dbo.tContentsInfo') is not null
begin
	print N'dbo.tContentsInfo 테이블이 존재 합니다.'
	goto tContentsInfo
	/**
		truncate table dbo.tContentsInfo
		drop table dbo.tContentsInfo
	**/
end

create table dbo.tContentsInfo
(	cMenuNo			int				not null
,	cWriteNo		bigint			not null
,	cLangNo			tinyint			not null	-- 1:en, 2:th, 3:vn
,	cContents		nvarchar(max)	not null
,	cView			bit				not null
,	cDrop			bit				not null
,	cDeleteTime		datetime			null
,	cCreateTime		datetime		not null
)

-- alter table dbo.tContentsInfo drop constraint PK_tContentsInfo_01
alter table dbo.tContentsInfo
add constraint PK_tContentsInfo_01
primary key clustered
(	cWriteNo
,	cMenuNo
,	cLangNo
)

tContentsInfo:
go

