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

use AuthorityWeb
go
if object_id('dbo.tEmailCert') is not null
begin
	print N'dbo.tEmailCert 테이블이 존재 합니다.'
	goto tEmailCert
	/**
		alter sequence dbo.sCertNo restart with 1
		truncate table dbo.tEmailCert
		drop table dbo.tEmailCert
	**/
end

create table dbo.tEmailCert
(	cCertNo			bigint		not null
,	cAccountNo		bigint		not null
,	cEmail			varchar(50)	not null
,	cCertKey		char(36)	not null
,	cRequestNo		tinyint		not null	-- 0:아이디찾기, 1:비밀번호찾기, 2:이메일인증
,	cStatus			tinyint			null	-- null:인증전, 1:인증완료, 2:인증대기, 3:인증실패
,	cFinishTime		datetime		null
,	cCreateTime		datetime	not null
)

-- alter table dbo.tEmailCert drop constraint PK_tEmailCert_01
alter table dbo.tEmailCert
add constraint PK_tEmailCert_01
primary key clustered
(	cCertNo desc
)

-- drop index tEmailCert.IX_tEmailCert_02
create nonclustered index IX_tEmailCert_02
on	dbo.tEmailCert
(	cCertKey
)
include
(	cRequestNo
,	cCreateTime
)

alter table dbo.tEmailCert add constraint DF_tEmailCert_01 default(next value for dbo.sCertNo) for cCertNo

tEmailCert:
go

use AuthorityWeb
go
if object_id('dbo.tGuestConsumer') is not null
begin
	print N'dbo.tGuestConsumer 테이블이 존재 합니다.'
	goto tGuestConsumer
	/**
		truncate table dbo.tGuestConsumer
		drop table dbo.tGuestConsumer
	**/
end

create table dbo.tGuestConsumer
(	cGameNo			int					not null
,	cAccountNo		bigint				not null
,	cToken			uniqueidentifier	not null
,	cSecret			char(27)			not null
,	cPlayerNo		bigint					null
,	cGameNick		nvarchar(20)			null
,	cModifyTime		datetime				null
,	cCreateTime		datetime			not null
)

-- alter table dbo.tGuestConsumer drop constraint PK_tGuestConsumer_01
alter table dbo.tGuestConsumer
add constraint PK_tGuestConsumer_01
primary key clustered
(	cAccountNo
,	cGameNo
)

-- drop index tGuestConsumer.IX_tGuestConsumer_02
create unique nonclustered index IX_tGuestConsumer_02
on	dbo.tGuestConsumer
(	cToken
)
include
(	cSecret
,	cPlayerNo
)

-- drop index tGuestConsumer.IX_tGuestConsumer_03
create unique nonclustered index IX_tGuestConsumer_03
on	dbo.tGuestConsumer
(	cGameNick
,	cGameNo
)
where cGameNick is not null

tGuestConsumer:
go

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

use AuthorityWeb
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
,	cLoginName		varchar(20)		not null
,	cHostName		varchar(30)		not null
,	cErrorNo		int					null
,	cUserError		int				not null
,	cSeverity		int					null
,	cState			int					null
,	cLineNo			int					null
,	cErrorMessage	nvarchar(max)		null
,	cCreateTime		datetime		not null
)

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

