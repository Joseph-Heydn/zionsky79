use AuthorityWeb
go
if object_id('dbo.tWithdrawLog') is not null
begin
	print N'dbo.tWithdrawLog 테이블이 존재 합니다.'
	goto tWithdrawLog
	/**
		alter sequence dbo.sDropNo restart with 1
		truncate table dbo.tWithdrawLog
		drop table dbo.tWithdrawLog
	**/
end

create table dbo.tWithdrawLog
(	cLogs			bigint			not null
,	cAccountNo		bigint			not null
,	cPublisher		tinyint			not null
,	cAccountId		varchar(20)			null
,	cCategory		smallint			null
,	cMemo			nvarchar(200)		null
,	cCancelTime		datetime			null
,	cDeleteTime		datetime			null
,	cCreateTime		datetime		not null
)

-- alter table dbo.tWithdrawLog drop constraint PK_tWithdrawLog_01
alter table dbo.tWithdrawLog
add constraint PK_tWithdrawLog_01
primary key clustered
(	cLogs desc
)

-- drop index tWithdrawLog.IX_tWithdrawLog_02
create nonclustered index IX_tWithdrawLog_02
on	dbo.tWithdrawLog
(	cAccountNo
)

alter table dbo.tWithdrawLog add constraint DF_tWithdrawLog_01 default(next value for dbo.sDropNo) for cLogs

tWithdrawLog:
go

