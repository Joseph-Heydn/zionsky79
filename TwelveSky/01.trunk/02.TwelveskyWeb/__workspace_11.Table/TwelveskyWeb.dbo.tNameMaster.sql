use TwelveskyWeb
go
if object_id('dbo.tNameMaster') is not null
begin
	print N'dbo.tNameMaster 테이블이 존재 합니다.'
	goto tNameMaster
	/**
		truncate table dbo.tNameMaster
		drop table dbo.tNameMaster
	**/
end

create table dbo.tNameMaster
(	cNameKey	int				not null
,	cLangNo		tinyint			not null
,	cName		nvarchar(30)	not null
)

alter table dbo.tNameMaster
add constraint PK_tNameMaster_01
primary key clustered
(	cNameKey
,	cLangNo
)

tNameMaster:
go

