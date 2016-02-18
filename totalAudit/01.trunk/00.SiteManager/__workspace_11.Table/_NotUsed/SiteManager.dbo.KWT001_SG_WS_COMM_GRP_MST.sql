use SiteManager
go
if object_id('dbo.KWT001_SG_WS_COMM_GRP_MST') is not null
begin
	print N'dbo.KWT001_SG_WS_COMM_GRP_MST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_COMM_GRP_MST
	/**
		truncate table dbo.KWT001_SG_WS_COMM_GRP_MST
		drop table dbo.KWT001_SG_WS_COMM_GRP_MST
	**/
end

create table dbo.KWT001_SG_WS_COMM_GRP_MST
(	site_grp_no		int				not null	-- 전체 그룹번호
,	comm_grp_no		int				not null	-- 그룹내 그룹번호
,	comm_grp_nm		nvarchar(20)	not null	-- 그룹 이름
,	orderby_no		smallint		not null	-- 정렬 순서
,	note_desc		nvarchar(100)		null	-- 설명
,	use_flag		bit				not null	-- 사용 여부
,	del_flag		bit				not null	-- 삭제 여부
,	upt_addr		varchar(15)			null	-- 변경한 ip
,	upt_time		datetime			null	-- 변경 시간
,	ipt_time		datetime		not null	-- 생성 시간
)

-- alter table dbo.KWT001_SG_WS_COMM_GRP_MST drop constraint PK_KWT001_SG_WS_COMM_GRP_MST_01
alter table dbo.KWT001_SG_WS_COMM_GRP_MST
add constraint PK_KWT001_SG_WS_COMM_GRP_MST_01
primary key clustered
(	site_grp_no
,	comm_grp_no
)

-- drop index KWT001_SG_WS_COMM_GRP_MST.IX_KWT001_SG_WS_COMM_GRP_MST_02
create unique nonclustered index IX_KWT001_SG_WS_COMM_GRP_MST_02
on	dbo.KWT001_SG_WS_COMM_GRP_MST
(	site_grp_no
,	comm_grp_no
)
include
(	orderby_no
,	use_flag
,	comm_grp_nm
)

alter table dbo.KWT001_SG_WS_COMM_GRP_MST add constraint DF_KWT001_SG_WS_COMM_GRP_MST_01 default(0) for del_flag
alter table dbo.KWT001_SG_WS_COMM_GRP_MST add constraint DF_KWT001_SG_WS_COMM_GRP_MST_02 default(getdate()) for ipt_time


truncate table dbo.KWT001_SG_WS_COMM_GRP_MST
insert into dbo.KWT001_SG_WS_COMM_GRP_MST
	(	site_grp_no
	,	comm_grp_no
	,	orderby_no
	,	use_flag
	,	comm_grp_nm
	,	note_desc
	)
values
-- 관리웹 메뉴
 (1001,1001001,1,1,N'공통관리'		,N'사이트 관리')
,(1001,1001002,2,1,N'회원관리'		,N'회원 관련 정보를 조회')
,(1001,1001003,4,1,N'게임관리'		,N'게임 운영을 위한 데이터 조작 및 일부 실시간 조회')
,(1001,1001004,6,1,N'게임통계'		,N'각종 게임 통계')
,(1001,1001005,8,1,N'게임로그'		,N'각종 플레이 기록 조회')
,(1001,1001006,5,1,N'이벤트관리'		,N'이벤트관리')
,(1001,1001007,7,1,N'쿠폰관리'		,N'쿠폰 관리')
,(1001,1001008,3,1,N'랭킹조회'		,N'각종 랭킹 정보 조회')
,(1001,1001009,9,1,N'게시판관리'		,N'Gong Field 웹사이트 게시판 관리')

-- 권한 그룹
,(2001,2001001,99,1,N'Default'		,N'기본 그룹이며 권한은 없다. 로그인만 가능하다.')
,(2001,2001002,01,1,N'Administrator',N'통합관리 개발자. 모든 페이지에 대한 권한이 있다.')
,(2001,2001003,02,1,N'Power User'	,N'개발자를 위한 그룹으로 일부 권한이 있다.')
,(2001,2001004,03,1,N'C/S Master'	,N'C/S 그룹장의 권한으로 팀원에게 권한을 부여할 수 있다.')
,(2001,2001005,04,1,N'C/S User'		,N'상담원 그룹으로 CS업무를 하기위해 필요한 권한만 있다.')
,(2001,2001006,05,1,N'Cupon Master'	,N'쿠폰 발급 및 조회 권한이 있다.')
,(2001,2001007,06,1,N'Event Master'	,N'이벤트 생성 및 조회 권한이 있다.')
,(2001,2001008,07,1,N'Static Viewer',N'통계를 조회할 수 있는 권한이 있다.')
,(2001,2001009,08,1,N'Web Guest'	,N'홍보웹 일반 권한 그룹')

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

KWT001_SG_WS_COMM_GRP_MST:
go

