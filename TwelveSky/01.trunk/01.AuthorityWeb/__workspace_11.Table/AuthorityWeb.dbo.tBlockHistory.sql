use AuthorityWeb
go
if object_id('dbo.tBlockHistory') is not null
begin
	print N'dbo.tBlockHistory 테이블이 존재 합니다.'
	goto tBlockHistory
	/**
		alter sequence dbo.sBlockNo restart with 1
		truncate table dbo.tBlockHistory
		drop table dbo.tBlockHistory
	**/
end

create table dbo.tBlockHistory
(	cBolckNo		int				not null
,	cGameNo			int					null
,	cAccountNo		bigint			not null
,	cBlockType		smallint		not null
,	cMemo			nvarchar(150)		null
,	cAdminNo		int				not null
,	cStartTime		datetime		not null
,	cLimitTime		datetime		not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.tBlockHistory drop constraint PK_tBlockHistory_01
alter table dbo.tBlockHistory
add constraint PK_tBlockHistory_01
primary key clustered
(	cBolckNo
)

-- drop index tBlockHistory.IX_tBlockHistory_02
create nonclustered index IX_tBlockHistory_02
on	dbo.tBlockHistory
(	cAccountNo
,	cGameNo
)
include
(	cBlockType
)

alter table dbo.tBlockHistory add constraint DF_tBlockHistory_01 default(next value for dbo.sBlockNo) for cBolckNo

tBlockHistory:
go

