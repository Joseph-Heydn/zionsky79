use AuthorityWeb
go
if object_id('dbo.tSocialDetail') is not null
begin
	print N'dbo.tSocialDetail 테이블이 존재 합니다.'
	goto tSocialDetail
	/**
		truncate table dbo.tSocialDetail
		drop table dbo.tSocialDetail
	**/
end

create table dbo.tSocialDetail
(	cAccountNo		bigint			not null
,	cPublisher		tinyint			not null
,	cUserName		nvarchar(16)		null
,	cLoginTime		datetime		not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.tSocialDetail drop constraint PK_tSocialDetail_01
alter table dbo.tSocialDetail
add constraint PK_tSocialDetail_01
primary key clustered
(	cAccountNo
)

-- drop index tSocialDetail.IX_tSocialDetail_02
create unique nonclustered index IX_tSocialDetail_02
on	dbo.tSocialDetail
(	cUserName
)
where cUserName is not null

tSocialDetail:
go

