use TwelveskyWeb
go
if object_id('dbo.tReportInfo') is not null
begin
	print N'dbo.tReportInfo 테이블이 존재 합니다.'
	goto tReportInfo
	/**
		alter sequence dbo.sReportNo restart with 1
		truncate table dbo.tReportInfo
		drop table dbo.tReportInfo
	**/
end

create table dbo.tReportInfo
(	cReportNo		bigint			not null
,	cMenuNo			int				not null
,	cWriteNo		bigint			not null
,	cCommtNo		bigint			not null
,	cTgAccountNo	bigint			not null
,	cTgNickName		nvarchar(20)	not null
,	cRpAccountNo	bigint			not null
,	cRpNickName		nvarchar(20)	not null
,	cType			tinyint			not null	-- 1:글추천, 2:신고, 3:반대, 11:댓글추천, 12:신고, 13:반대
,	cReason			tinyint				null
,	cCreateTime		datetime		not null
)

-- drop index tReportInfo.IX_tReportInfo_02
-- alter table dbo.tReportInfo drop constraint PK_tReportInfo_01
alter table dbo.tReportInfo
add constraint PK_tReportInfo_01
primary key clustered
(	cReportNo desc
)

-- drop index tReportInfo.IX_tReportInfo_02
create unique nonclustered index IX_tReportInfo_02
on	dbo.tReportInfo
(	cWriteNo
,	cCommtNo
,	cRpAccountNo
,	cType
)

alter table dbo.tReportInfo add constraint DF_tReportInfo_01 default(next value for dbo.sReportNo) for cReportNo

tReportInfo:
go

