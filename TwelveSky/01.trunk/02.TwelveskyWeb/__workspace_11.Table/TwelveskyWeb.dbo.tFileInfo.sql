use TwelveskyWeb
go
if object_id('dbo.tFileInfo') is not null
begin
	print N'dbo.tFileInfo 테이블이 존재 합니다.'
	goto tFileInfo
	/**
		alter sequence dbo.sFileNo restart with 7000000001
		truncate table dbo.tFileInfo
		drop table dbo.tFileInfo
	**/
end

create table dbo.tFileInfo
(	cMenuNo			int				not null	-- 파일이 저장되는 폴더
,	cWriteNo		bigint			not null
,	cFileNo			bigint			not null
,	cFileName		nvarchar(100)	not null
,	cFileExt		char(3)			not null
,	cFileSize		int				not null
,	cDeleteTime		datetime			null
,	cCreateTime		datetime		not null
)

-- drop index tFileInfo.IX_tFileInfo_02
-- alter table dbo.tFileInfo drop constraint PK_tFileInfo_01
alter table dbo.tFileInfo
add constraint PK_tFileInfo_01
primary key clustered
(	cWriteNo
,	cFileNo
)

-- drop index tFileInfo.IX_tFileInfo_02
create unique nonclustered index IX_tFileInfo_02
on	dbo.tFileInfo
(	cFileNo
)

-- alter table dbo.tFileInfo drop constraint DF_tFileInfo_01
alter table dbo.tFileInfo add constraint DF_tFileInfo_01 default(next value for dbo.sFileNo) for cFileNo

tFileInfo:
go

