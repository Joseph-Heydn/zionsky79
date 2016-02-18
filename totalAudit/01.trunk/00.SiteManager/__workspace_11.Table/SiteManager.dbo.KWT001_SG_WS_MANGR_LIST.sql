use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MANGR_LIST') is not null
begin
	print N'dbo.KWT001_SG_WS_MANGR_LIST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MANGR_LIST
	/**
		alter sequence dbo.sAdminNo restart with 100000001
		truncate table dbo.KWT001_SG_WS_MANGR_LIST
		drop table dbo.KWT001_SG_WS_MANGR_LIST
	**/
end

create table dbo.KWT001_SG_WS_MANGR_LIST
(	cAdminNo		int				not null	-- 유저 번호
,	cAdminId		varchar(50)		not null	-- 아이디
,	cPassword		binary(70)		not null	-- 비번
,	cAdminName		nvarchar(20)	not null	-- 이름
,	cDeptNo			int				not null	-- 부서 그룹
,	cIsUsed			bit					null	-- 사용여부
,	cNoteText		nvarchar(30)		null	-- 설명
,	cHostIp			varchar(15)			null	-- 변경 ip
,	cLoginTime		datetime			null	-- 접속시간
,	cModifyTime		datetime			null	-- 변경 시간
,	cCreateTime		datetime		not null	-- 생성 시간
)

-- alter table dbo.KWT001_SG_WS_MANGR_LIST drop constraint PK_KWT001_SG_WS_MANGR_LIST_01
alter table dbo.KWT001_SG_WS_MANGR_LIST
add constraint PK_KWT001_SG_WS_MANGR_LIST_01
primary key clustered
(	cAdminNo desc
)

-- drop index KWT001_SG_WS_MANGR_LIST.IX_KWT001_SG_WS_MANGR_LIST_02
create unique nonclustered index IX_KWT001_SG_WS_MANGR_LIST_02
on	dbo.KWT001_SG_WS_MANGR_LIST
(	cAdminName
,	cAdminId
)
include
(	cIsUsed
,	cDeptNo
,	cNoteText
)

-- drop index KWT001_SG_WS_MANGR_LIST.IX_KWT001_SG_WS_MANGR_LIST_03
create unique nonclustered index IX_KWT001_SG_WS_MANGR_LIST_03
on	dbo.KWT001_SG_WS_MANGR_LIST
(	cAdminName
)

-- drop index KWT001_SG_WS_MANGR_LIST.IX_KWT001_SG_WS_MANGR_LIST_04
create unique nonclustered index IX_KWT001_SG_WS_MANGR_LIST_04
on	dbo.KWT001_SG_WS_MANGR_LIST
(	cAdminId
)

alter table dbo.KWT001_SG_WS_MANGR_LIST add constraint DF_KWT001_SG_WS_MANGR_LIST_01 default(next value for dbo.sAdminNo) for cAdminNo

truncate table dbo.KWT001_SG_WS_MANGR_LIST
insert into dbo.KWT001_SG_WS_MANGR_LIST
values (next value for dbo.sAdminNo,'likethis79@daum.net',pwdencrypt('686e5a2a465a47fbbe853777b316923245930d4c92b02958f10cbe9ee2572ef4'),N'진훈식',3001002,1,'',null,'',null,getdate())

grant select on dbo.KWT001_SG_WS_MANGR_LIST to [opwebuser]

KWT001_SG_WS_MANGR_LIST:
go

