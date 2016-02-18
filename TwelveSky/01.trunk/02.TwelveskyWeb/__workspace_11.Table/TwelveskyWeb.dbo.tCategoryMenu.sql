use TwelveskyWeb
go
if object_id('dbo.tCategoryMenu') is not null
begin
	print N'dbo.tCategoryMenu 테이블이 존재 합니다.'
	goto tCategoryMenu
	/**
		truncate table dbo.tCategoryMenu
		drop table dbo.tCategoryMenu
	**/
end

create table dbo.tCategoryMenu
(	cLogs			int				not null identity(101,1)
,	cMenuNo			int				not null
,	cLangNo			tinyint			not null
,	cStep			tinyint			not null
,	cRefs			tinyint			not null
,	cCategory		tinyint			not null
,	cCateName		nvarchar(30)	not null
,	cWriteCnt		int				not null
,	cView			bit				not null
,	cUsing			bit				not null
,	cOrderBy		tinyint			not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.tCategoryMenu drop constraint PK_tCategoryMenu_01
alter table dbo.tCategoryMenu
add constraint PK_tCategoryMenu_01
primary key clustered
(	cLogs
)

create nonclustered index IX_tCategoryMenu_02
on	dbo.tCategoryMenu
(	cMenuNo
)

alter table dbo.tCategoryMenu add constraint DF_tCategoryMenu_01 default(0) for cWriteCnt
alter table dbo.tCategoryMenu add constraint DF_tCategoryMenu_02 default(getdate()) for cCreateTime

truncate table dbo.tCategoryMenu
insert into dbo.tCategoryMenu
	(	cMenuNo
	,	cLangNo
	,	cStep
	,	cRefs
	,	cCategory
	,	cWriteCnt
	,	cView
	,	cUsing
	,	cOrderBy
	,	cCreateTime
	,	cCateName
	)
values
 (1000020,1,1,0,1,0,1,1,1,getdate(), N'General')
,(1000020,1,1,0,2,0,1,1,2,getdate(), N'Technical')
,(1000020,1,1,0,3,0,1,1,3,getdate(), N'Billing')
,(1000020,1,1,0,4,0,1,1,4,getdate(), N'Others')
-- General
,(1000020,1,2,1,1,0,1,1,1,getdate(), N'Registration')
,(1000020,1,2,1,2,0,1,1,2,getdate(), N'Managing the account')
,(1000020,1,2,1,3,0,1,1,3,getdate(), N'Security')
-- Technical
,(1000020,1,2,2,1,0,1,1,1,getdate(), N'Log In error')
,(1000020,1,2,2,2,0,1,1,2,getdate(), N'Disconnection')
,(1000020,1,2,2,3,0,1,1,3,getdate(), N'Client installation')
-- Billing
,(1000020,1,2,3,1,0,1,1,1,getdate(), N'Refund')
,(1000020,1,2,3,2,0,1,1,2,getdate(), N'Fill up')
-- Others
,(1000020,1,2,4,1,0,1,1,1,getdate(), N'Game')
,(1000020,1,2,4,2,0,1,1,2,getdate(), N'Abuse')
,(1000020,1,2,4,3,0,1,1,3,getdate(), N'Others')

tCategoryMenu:
go

