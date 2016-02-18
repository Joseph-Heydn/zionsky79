use AuthorityWeb
go
if object_id('dbo.tConsumerInfo') is not null
begin
	print N'dbo.tConsumerInfo 테이블이 존재 합니다.'
	goto tConsumerInfo
	/**
		truncate table dbo.tConsumerInfo
		drop table dbo.tConsumerInfo
	**/
end

create table dbo.tConsumerInfo
(	cGameNo			int				not null
,	cGameCode		varchar(10)		not null
,	cGameName		nvarchar(20)	not null
,	cAccessType		tinyint			not null	-- 1:웹, 2:모바일
,	cDomainName		varchar(30)		not null
,	cCallBackURL	varchar(100)		null
,	cConsumerKey	char(10)		not null
,	cSecret			char(15)		not null
,	cStatus			tinyint			not null	-- 1:사용, 2:종료(계약만료), 3:정지(일시정시)
,	cCreateTime		datetime		not null
)

-- alter table dbo.tConsumerInfo drop constraint PK_tConsumerInfo_01
alter table dbo.tConsumerInfo
add constraint PK_tConsumerInfo_01
primary key clustered
(	cGameNo
)

truncate table dbo.tConsumerInfo
insert into dbo.tConsumerInfo
values (20150001, 'FC', N'풀카운트', 1, 'www.fullcount.co.kr', null, 'pH0k32NwZk', '5Di5crxIml3k1i1', 1, getdate())

tConsumerInfo:
go

