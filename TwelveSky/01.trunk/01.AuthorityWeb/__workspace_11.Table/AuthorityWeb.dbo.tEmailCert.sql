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

