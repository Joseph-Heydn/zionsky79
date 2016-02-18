use TwelveskyWeb
go
if object_id('dbo.tSpErrorLog') is not null
begin
	print N'dbo.tSpErrorLog 테이블이 존재 합니다.'
	goto tSpErrorLog
	/**
		alter sequence dbo.sErrorNo restart with 1
		truncate table dbo.tSpErrorLog
		drop table dbo.tSpErrorLog
	**/
end

create table dbo.tSpErrorLog
(	cLogs			int				not null
,	cDataBase		varchar(30)		not null
,	cProcedure		varchar(50)			null
,	cAuther			varchar(20)		not null
,	cLoginName		varchar(50)		not null
,	cHostName		varchar(50)		not null
,	cErrorNo		int					null
,	cUserError		int				not null
,	cSeverity		int					null
,	cState			int					null
,	cLineNo			int					null
,	cErrorMessage	nvarchar(max)		null
,	cCreateTime		datetime		not null
)

-- drop index tSpErrorLog.IX_tSpErrorLog_02
-- alter table dbo.tSpErrorLog drop constraint PK_tSpErrorLog_01
alter table dbo.tSpErrorLog
add constraint PK_tSpErrorLog_01
primary key clustered
(	cLogs desc
)

-- drop index tSpErrorLog.IX_tSpErrorLog_02
create nonclustered index IX_tSpErrorLog_02
on	dbo.tSpErrorLog
(	cProcedure
)

alter table dbo.tSpErrorLog add constraint DF_tSpErrorLog_01 default(next value for dbo.sErrorNo) for cLogs

tSpErrorLog:
go

