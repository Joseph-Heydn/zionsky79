use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MENU_NAME') is not null
begin
	print N'dbo.KWT001_SG_WS_MENU_NAME 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MENU_NAME
	/**
		truncate table dbo.KWT001_SG_WS_MENU_NAME
		drop table dbo.KWT001_SG_WS_MENU_NAME
	**/
end

create table dbo.KWT001_SG_WS_MENU_NAME
(	cMenuNo		int				not null
,	cLangNo		tinyint			not null
,	cMenuName	nvarchar(30)	not null
)

-- alter table dbo.KWT001_SG_WS_MENU_NAME drop constraint PK_KWT001_SG_WS_MENU_NAME_01
alter table dbo.KWT001_SG_WS_MENU_NAME
add constraint PK_KWT001_SG_WS_MENU_NAME_01
primary key clustered
(	cMenuNo
,	cLangNo
)

KWT001_SG_WS_MENU_NAME:
go

