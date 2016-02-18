use SiteManager
go
if object_id('dbo.KWT001_SG_WS_COMM_GROUP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_COMM_GROUP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_COMM_GROUP_MST
	/**
		truncate table dbo.KWT001_SG_WS_COMM_GROUP_MST
		drop table dbo.KWT001_SG_WS_COMM_GROUP_MST
	**/
end

create table dbo.KWT001_SG_WS_COMM_GROUP_MST
(	cSiteGroup		smallint		not null	-- 전체 그룹번호
,	cCommGroup		int				not null	-- 그룹내 그룹번호
,	cCommName		nvarchar(20)	not null	-- 그룹 이름
,	cOrderBy		tinyint			not null	-- 정렬 순서
,	cIsUsed			bit				not null	-- 사용 여부
,	cIsView			bit				not null	-- 노출 여부
,	cHostIp			varchar(15)			null	-- 변경한 ip
,	cNoteText		nvarchar(50)		null	-- 설명
,	cModifyTime		datetime			null	-- 변경 시간
,	cCreateTime		datetime		not null	-- 생성 시간
)

-- alter table dbo.KWT001_SG_WS_COMM_GROUP_MST drop constraint PK_KWT001_SG_WS_COMM_GROUP_MST_01
alter table dbo.KWT001_SG_WS_COMM_GROUP_MST
add constraint PK_KWT001_SG_WS_COMM_GROUP_MST_01
primary key clustered
(	cSiteGroup
,	cCommGroup
)

-- drop index KWT001_SG_WS_COMM_GROUP_MST.IX_KWT001_SG_WS_COMM_GROUP_MST_02
create unique nonclustered index IX_KWT001_SG_WS_COMM_GROUP_MST_02
on	dbo.KWT001_SG_WS_COMM_GROUP_MST
(	cSiteGroup
,	cCommGroup
)
include
(	cOrderBy
,	cIsUsed
,	cCommName
)

alter table dbo.KWT001_SG_WS_COMM_GROUP_MST add constraint DF_KWT001_SG_WS_COMM_GROUP_MST_01 default(1) for cIsView
alter table dbo.KWT001_SG_WS_COMM_GROUP_MST add constraint DF_KWT001_SG_WS_COMM_GROUP_MST_02 default(getdate()) for cCreateTime


truncate table dbo.KWT001_SG_WS_COMM_GROUP_MST
insert into dbo.KWT001_SG_WS_COMM_GROUP_MST
	(	cSiteGroup
	,	cCommGroup
	,	cOrderBy
	,	cIsUsed
	,	cCommName
	,	cNoteText
	)
values
-- 관리웹 메뉴
 (1001,1001001,01,1,N'Common'		,N'사이트 관리')
,(1001,1001002,02,1,N'Main'			,N'메인 화면 켄텐츠 관리')
,(1001,1001003,03,1,N'News'			,N'공지사항과 같은 읽기전용 게시판')
,(1001,1001004,04,1,N'Game Guide'	,N'각 게임에 대한 소개, 가이드 게시판')
,(1001,1001005,05,1,N'Community'	,N'일반 공개성 게시판')
,(1001,1001006,06,1,N'Media'		,N'영상, 포토 게시판')
,(1001,1001007,07,1,N'Shop'			,N'아이템 판매 게시판')
,(1001,1001008,08,1,N'Support'		,N'유저 문의 게시판')
,(1001,1001009,09,1,N'Policy'		,N'정책 & 이용약관')
,(1001,1001010,10,1,N'User'			,N'유저 정보 조회')

-- 권한 그룹
,(2001,2001001,99,1,N'Default'		,N'기본 그룹이며 권한은 없다. 로그인만 가능하다.')
,(2001,2001002,01,1,N'Administrator',N'통합관리 개발자. 모든 페이지에 대한 권한이 있다.')
,(2001,2001003,02,1,N'Power User'	,N'개발자를 위한 그룹으로 일부 권한이 있다.')
,(2001,2001004,03,1,N'C/S Master'	,N'C/S 그룹장의 권한으로 팀원에게 권한을 부여할 수 있다.')
,(2001,2001005,04,1,N'C/S User'		,N'상담원 그룹으로 CS업무를 하기위해 필요한 권한만 있다.')
,(2001,2001006,05,1,N'Cupon Master'	,N'쿠폰 발급 및 조회 권한이 있다.')
,(2001,2001007,06,1,N'Event Master'	,N'이벤트 생성 및 조회 권한이 있다.')
,(2001,2001008,07,1,N'Static Viewer',N'통계를 조회할 수 있는 권한이 있다.')
,(2001,2001009,08,1,N'Web Member'	,N'공식웹 회원 권한 그룹')
,(2001,2001010,09,1,N'Web Guest'	,N'공식웹 일반 권한 그룹')

-- 부서 그룹
,(3001,3001001,1,1,N'서버'			,N'게임 서버팀')
,(3001,3001002,2,1,N'디비'			,N'디비 서버팀')
,(3001,3001003,3,1,N'클라이언트'		,N'클라이언트팀')
,(3001,3001004,4,1,N'배경'			,N'배경팀')
,(3001,3001005,5,1,N'캐릭터'			,N'캐릭터팀')
,(3001,3001006,6,1,N'C/S'			,N'C/S팀')
,(3001,3001007,7,1,N'기획'			,N'기획팀')
,(3001,3001008,8,1,N'사업'			,N'사업팀')
,(3001,3001009,9,1,N'운영'			,N'운영팀')

KWT001_SG_WS_COMM_GROUP_MST:
go

