use AuthorityWeb
go
if object_id('dbo.tAccountInfo') is not null
begin
	print N'dbo.tAccountInfo 테이블이 존재 합니다.'
	goto tAccountInfo
	/**
		alter sequence dbo.sAccountNo restart with 100000001
		truncate table dbo.tAccountInfo
		drop table dbo.tAccountInfo
	**/
end

create table dbo.tAccountInfo
(	cAccountNo		bigint			not null
,	cPublisher		tinyint			not null
,	cAccountId		varchar(50)		not null
,	cPassword		binary(70)		not null
,	cNickName		nvarchar(20)	not null
,	cEmail			varchar(50)		not null
,	cHostIp			varchar(15)		not null
,	cExts			char(3)				null
,	cStatus			tinyint			not null	-- 1:정상, 11:탈퇴신청, 99:탈퇴완료
,	cIsEmail		bit				not null
,	cIsPhoto		bit				not null
,	cBirthDay		smalldatetime		null
,	cLoginTime		datetime			null
,	cCertfyTime		datetime			null
,	cDeleteTime		datetime			null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

-- drop index tAccountInfo.IX_tAccountInfo_02
-- drop index tAccountInfo.IX_tAccountInfo_03
-- drop index tAccountInfo.IX_tAccountInfo_04
-- drop index tAccountInfo.IX_tAccountInfo_05
-- alter table dbo.tAccountInfo drop constraint PK_tAccountInfo_01
alter table dbo.tAccountInfo
add constraint PK_tAccountInfo_01
primary key clustered
(	cAccountNo desc
)

-- drop index tAccountInfo.IX_tAccountInfo_02
create unique nonclustered index IX_tAccountInfo_02
on	dbo.tAccountInfo
(	cAccountId
)
include
(	cPassword
,	cStatus
)

-- drop index tAccountInfo.IX_tAccountInfo_03
create nonclustered index IX_tAccountInfo_03
on	dbo.tAccountInfo
(	cCreateTime
)

-- drop index tAccountInfo.IX_tAccountInfo_04
create unique nonclustered index IX_tAccountInfo_04
on	dbo.tAccountInfo
(	cNickName
)
include
(	cAccountId
,	cEmail
,	cDeleteTime
)

-- drop index tAccountInfo.IX_tAccountInfo_05
create unique nonclustered index IX_tAccountInfo_05
on	dbo.tAccountInfo
(	cAccountId
)
include
(	cEmail
,	cDeleteTime
)

alter table dbo.tAccountInfo add constraint DF_tAccountInfo_01 default(next value for dbo.sAccountNo) for cAccountNo

tAccountInfo:
go

