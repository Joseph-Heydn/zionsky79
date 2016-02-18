use AuthorityWeb
go
if object_id('dbo.tAccountDetail') is not null
begin
	print N'dbo.tAccountDetail 테이블이 존재 합니다.'
	goto tAccountDetail
	/**
		truncate table dbo.tAccountDetail
		drop table dbo.tAccountDetail
	**/
end

create table dbo.tAccountDetail
(	cAccountNo		bigint			not null
,	cUserName		nvarchar(20)		null
,	cBirthDay		smalldatetime		null
,	cHPCompany		tinyint				null	-- 1:SK, 2:KT, 3:LG
,	cCellPhone		varchar(15)			null
,	cPhoneAgree		bit					null
,	cEmailAgree		bit				not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.tAccountDetail drop constraint PK_tAccountDetail_01
alter table dbo.tAccountDetail
add constraint PK_tAccountDetail_01
primary key clustered
(	cAccountNo
)

-- drop index tAccountDetail.IX_tAccountDetail_02
create nonclustered index IX_tAccountDetail_02
on	dbo.tAccountDetail
(	cUserName
)
where cUserName is not null

tAccountDetail:
go

