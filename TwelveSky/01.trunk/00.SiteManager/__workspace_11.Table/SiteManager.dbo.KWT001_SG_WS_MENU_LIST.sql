use SiteManager
go
if object_id('dbo.KWT001_SG_WS_MENU_LIST') is not null
begin
	print N'dbo.KWT001_SG_WS_MENU_LIST 테이블이 존재 합니다.'
	goto KWT001_SG_WS_MENU_LIST
	/**
		truncate table dbo.KWT001_SG_WS_MENU_LIST
		drop table dbo.KWT001_SG_WS_MENU_LIST
	**/
end

create table dbo.KWT001_SG_WS_MENU_LIST
(	cMenuGroup		int				not null
,	cMenuNo			int				not null
,	cMenuName		nvarchar(20)	not null
,	cExecUrl		varchar(120)	not null
,	cImageUrl		varchar(120)		null
,	cNoteText		nvarchar(50)		null
,	cIsUsed			bit				not null
,	cIsView			bit				not null
,	cOrderBy		tinyint			not null
,	cStep			tinyint			not null
,	cHostIp			varchar(15)			null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

-- alter table dbo.KWT001_SG_WS_MENU_LIST drop constraint PK_KWT001_SG_WS_MENU_LIST_01
alter table dbo.KWT001_SG_WS_MENU_LIST
add constraint PK_KWT001_SG_WS_MENU_LIST_01
primary key clustered
(	cMenuGroup
,	cMenuNo
)

-- drop index KWT001_SG_WS_MENU_LIST.IX_KWT001_SG_WS_MENU_LIST_02
create unique nonclustered index IX_KWT001_SG_WS_MENU_LIST_02
on	dbo.KWT001_SG_WS_MENU_LIST
(	cExecUrl
,	cIsUsed
,	cOrderBy
)
/*
-- drop index KWT001_SG_WS_MENU_LIST.IX_KWT001_SG_WS_MENU_LIST_03
create unique nonclustered index IX_KWT001_SG_WS_MENU_LIST_03
on	dbo.KWT001_SG_WS_MENU_LIST
(	cMenuGroup
,	cOrderBy
)
include
(	cIsUsed
,	cIsView
)
*/
alter table dbo.KWT001_SG_WS_MENU_LIST add constraint DF_KWT001_SG_WS_MENU_LIST_01 default(getdate()) for cCreateTime


truncate table dbo.KWT001_SG_WS_MENU_LIST
insert into dbo.KWT001_SG_WS_MENU_LIST
	(	cMenuGroup
	,	cMenuNo
	,	cIsUsed
	,	cIsView
	,	cOrderBy
	,	cStep
	,	cExecUrl
	,	cMenuName
	,	cNoteText
	,	cImageUrl
	)
values
 (1001001,1001000,1,1,0,0,'/app/1001000'							,N'Common'		,N'사이트 관리'				,null)
,(1001002,1002000,1,1,0,0,'/app/1002000'							,N'Main'		,N'메인 화면 켄텐츠 관리'		,null)
,(1001003,1003000,1,1,0,0,'/web/board/list.aspx?m=1000004'			,N'News'		,N'공지사항과 같은 읽기전용'	,'top_navi_01.png')
,(1001004,1004000,1,1,0,0,'/web/board/guide.aspx?m=1000006&w=1'		,N'Game Guide'	,N'게임에 대한 소개, 가이드'	,'top_navi_02.png')
,(1001005,1005000,1,1,0,0,'/web/board/list.aspx?m=1000007'			,N'Community'	,N'일반 공개성 게시판'		,'top_navi_03.png')
,(1001006,1006000,1,1,0,0,'/web/board/list.aspx?m=1000011'			,N'Media'		,N'영상, 포토 게시판'		,'top_navi_04.png')
,(1001007,1007000,1,1,0,0,'/web/board/items.aspx?m=1000014'			,N'Shop'		,N'아이템 소개 및 판매'		,'top_navi_05.png')
,(1001008,1008000,1,0,0,0,'/app/1008000'							,N'My Page'		,N'개인정보 및 1:1문의'		,null)
,(1001009,1009000,1,0,0,0,'/app/1009000'							,N'My Page'		,N'Id/Password 찾기'			,null)
,(1001010,1010000,1,0,0,0,'/app/1010000'							,N'Sign up'		,N'회원 가입'				,null)
,(1001011,1011000,1,0,0,0,'/app/1011000'							,N'Policy'		,N'정책 & 이용약관'			,null)
,(1001012,1012000,1,1,0,0,'/app/1012000'							,N'User'		,N'유저 정보 조회'			,null)

insert into dbo.KWT001_SG_WS_MENU_LIST
	(	cMenuGroup
	,	cMenuNo
	,	cIsUsed
	,	cIsView
	,	cOrderBy
	,	cStep
	,	cExecUrl
	,	cMenuName
	,	cNoteText
	)
values
 (1001001,1001001,1,1,01,0,'/site/baseCode.aspx?m=1'				,N'사이트 그룹'			,N'메뉴 그룹등록/수정')
,(1001001,1001002,1,1,02,0,'/site/adminGroups.aspx?m=2'				,N'관리자 그룹'			,N'구성원관리, 그룹등록/수정, 그룹 역할 설정')
,(1001001,1001003,1,1,03,0,'/site/adminList.aspx?m=3'				,N'관리자 목록'			,N'관리자 추가/수정/삭제, 그룹할당')
,(1001001,1001004,1,1,04,0,'/site/menuList.aspx?m=4'				,N'메뉴 목록'			,N'메뉴등록/삭제그룹에 매뉴 할당')
,(1001001,1001005,1,1,05,0,'/site/actionLog.aspx?m=5'				,N'관리자 작업내역'		,N'작업 내역 리스트를 조회')
,(1001001,1001006,1,1,06,0,'/site/password.aspx?m=6'				,N'비밀번호 변경'		,N'로그인 한 유저 비밀번호 변경')
,(1001001,1001007,1,1,07,0,'/site/encryptTest.aspx?m=7'				,N'Password Hash'		,N'MD5 테스트 페이지')
,(1001001,1001099,1,0,99,0,'/'										,N'메인페이지'			,N'main page')
-- Site Main manager
,(1001002,1002001,1,1,01,0,'/web/main/images.aspx?m=1000001'		,N'Main Image'			,N'메인 화면에 노출되는 슬라이드 이미지')
,(1001002,1002002,1,1,02,0,'/web/main/movies.aspx?m=1000002'		,N'Main Movie'			,N'메인 화면에 노출되는 동영상')
,(1001002,1002003,1,1,03,0,'/web/main/banner.aspx?m=1000003'		,N'Main Banner'			,N'메인 화면에 노출되는 좌/우 광고')
-- News
,(1001003,1003001,1,1,01,0,'/web/board/list.aspx?m=1000004'			,N'Announcements'		,N'News -&gt; Announcements')
,(1001003,1003002,1,1,02,0,'/web/board/list.aspx?m=1000005'			,N'Notice'				,N'News -&gt; Notice')
-- Game Guides
,(1001004,1004001,1,1,01,0,'/web/board/list.aspx?m=1000006'			,N'Guides List'			,N'Game Guides list')
,(1001004,1004002,1,1,02,0,'/web/board/guide.aspx?m=1000006&w=1'	,N'Story'				,N'Game Guides -&gt; Story')
,(1001004,1004003,1,1,03,0,'/web/board/guide.aspx?m=1000006&w=2'	,N'Introduction'		,N'Game Guides -&gt; Introduction')
,(1001004,1004004,1,1,04,0,'/web/board/guide.aspx?m=1000006&w=3'	,N'Game Feature'		,N'Game Guides -&gt; Game Feature')
,(1001004,1004005,1,1,05,0,'/web/board/guide.aspx?m=1000006&w=4'	,N'System Requirements'	,N'Game Guides -&gt; System Requirements')
,(1001004,1004006,1,1,06,0,'/web/board/guide.aspx?m=1000006&w=5'	,N'General Questions'	,N'Game Guides -&gt; General Questions')
,(1001004,1004007,1,1,07,0,'/web/board/guide.aspx?m=1000006&w=6'	,N'Getting Started'		,N'Game Guides -&gt; Getting Started')
,(1001004,1004008,1,1,08,0,'/web/board/guide.aspx?m=1000006&w=7'	,N'Class Info'			,N'Game Guides -&gt; Class Info')
,(1001004,1004009,1,0,09,8,'/web/board/guide.aspx?m=1000006&w=7'	,N'Guanyin'				,N'Game Guides -&gt; Class Info -&gt; Guanyin')
,(1001004,1004010,1,0,10,8,'/web/board/guide.aspx?m=1000006&w=8'	,N'Fujin'				,N'Game Guides -&gt; Class Info -&gt; Fujin')
,(1001004,1004011,1,0,11,8,'/web/board/guide.aspx?m=1000006&w=9'	,N'Jinong'				,N'Game Guides -&gt; Class Info -&gt; Jinong')
,(1001004,1004012,1,0,12,8,'/web/board/guide.aspx?m=1000006&w=10'	,N'Nangin'				,N'Game Guides -&gt; Class Info -&gt; Nangin')
,(1001004,1004013,1,1,13,0,'/web/board/guide.aspx?m=1000006&w=11'	,N'Game Play'			,N'Game Guides -&gt; Game Play')
,(1001004,1004014,1,1,14,0,'/web/board/guide.aspx?m=1000006&w=12'	,N'Pet Information'		,N'Game Guides -&gt; Pet Information')
,(1001004,1004015,1,1,15,0,'/web/board/guide.aspx?m=1000006&w=13'	,N'Items'				,N'Game Guides -&gt; Items')
,(1001004,1004016,1,1,16,0,'/web/board/guide.aspx?m=1000006&w=14'	,N'PvP Combat'			,N'Game Guides -&gt; PvP Combat')
,(1001004,1004017,1,1,17,0,'/web/board/guide.aspx?m=1000006&w=15'	,N'Player Interaction'	,N'Game Guides -&gt; Player Interaction')
,(1001004,1004018,1,1,18,0,'/web/board/guide.aspx?m=1000006&w=16'	,N'Government'			,N'Game Guides -&gt; Government')
,(1001004,1004019,1,1,19,0,'/web/board/guide.aspx?m=1000006&w=17'	,N'NPCs'				,N'Game Guides -&gt; NPCs')
-- Community
,(1001005,1005001,1,1,01,0,'/web/board/list.aspx?m=1000007'			,N'General Discussion'	,N'Community -&gt; General Discussion')
,(1001005,1005002,1,1,02,0,'/web/board/list.aspx?m=1000008'			,N'Tips / Knowhow'		,N'Community -&gt; Tips / Knowhow')
,(1001005,1005003,1,1,03,0,'/web/board/list.aspx?m=1000009'			,N'Problem Solution'	,N'Community -&gt; Problem Solution')
,(1001005,1005004,1,1,04,0,'/web/board/list.aspx?m=1000010'			,N'Item Trade'			,N'Community -&gt; Item Trade')
-- Media
,(1001006,1006001,1,1,01,0,'/web/board/list.aspx?m=1000011'			,N'Video'				,N'Media -&gt; Video')
,(1001006,1006002,1,1,02,0,'/web/board/list.aspx?m=1000012'			,N'Artwork'				,N'Media -&gt; Artwork')
,(1001006,1006003,1,1,03,0,'/web/board/list.aspx?m=1000013'			,N'Screenshots'			,N'Media -&gt; Screenshots')
-- Shop
,(1001007,1007001,1,1,01,0,'/web/board/items.aspx?m=1000014'		,N'Item List'			,N'Shop -&gt; Item List')
,(1001007,1007002,1,0,02,0,'/web/board/items.aspx?m=1000014'		,N'Upgrading'			,N'Shop -&gt; Item List -&gt; Upgrading')
,(1001007,1007003,1,0,03,0,'/web/board/items.aspx?m=1000015'		,N'Buffs'				,N'Shop -&gt; Item List -&gt; Buffs')
,(1001007,1007004,1,0,04,0,'/web/board/items.aspx?m=1000016'		,N'Vanity'				,N'Shop -&gt; Item List -&gt; Vanity')
,(1001007,1007005,1,0,05,0,'/web/board/items.aspx?m=1000017'		,N'Miscellaeous'		,N'Shop -&gt; Item List -&gt; Miscellaeous')
-- 타사이트로 넘어가는 링크
,(1001007,1007006,1,1,06,0,'javascript:fnMoveBill(''/fillUp/payment.aspx'')'	,N'Cash'				,N'Shop -&gt; Cash')
,(1001007,1007007,1,1,07,6,'javascript:fnMoveBill(''/fillUp/payment.aspx'')'	,N'Buy Gp coins'		,N'Shop -&gt; Item List -&gt; Upgrading')
,(1001007,1007008,1,1,08,6,'javascript:fnMoveBill(''/history/fillUp.aspx'')'	,N'Fill-up history'		,N'Shop -&gt; Item List -&gt; Buffs')
,(1001007,1007009,1,1,09,6,'javascript:fnMoveBill(''/history/purchase.aspx'')'	,N'Purchase history'	,N'Shop -&gt; Item List -&gt; Vanity')
,(1001007,1007010,1,1,10,6,'javascript:fnMoveBill(''/policy/coins.aspx'')'		,N'Coins policy'		,N'Shop -&gt; Item List -&gt; Miscellaeous')
-- My Page
,(1001008,1008001,1,1,01,0,'/web/privacy/profile.aspx?m=1000018'	,N'Profile'				,N'My Page -&gt; Profile')
,(1001008,1008002,1,1,02,0,'/web/privacy/password.aspx?m=1000019'	,N'Change Password'		,N'My Page -&gt; Change Password')
,(1001008,1008003,1,1,03,0,'/web/privacy/history.aspx?m=1000020'	,N'Support'				,N'My Page -&gt; Support')
,(1001008,1008004,1,1,04,3,'/web/privacy/history.aspx?m=1000020'	,N'My Question'			,N'My Page -&gt; My Question')
,(1001008,1008005,1,1,05,3,'/web/privacy/contatct.aspx?m=1000021'	,N'Contatct Us'			,N'My Page -&gt; Contatct Us')
,(1001008,1008006,1,1,06,0,'/web/privacy/withdraw.aspx?m=1000022'	,N'Deactivate account'	,N'My Page -&gt; Deactivate account')
-- My Page2
,(1001009,1009001,1,1,01,0,'/web/guest/findId.aspx?m=1000023'		,N'Find Id'				,N'My Page -&gt; Find Id')
,(1001009,1009002,1,1,02,0,'/web/guest/findPass.aspx?m=1000024'		,N'Find Password'		,N'My Page -&gt; Find Password')
,(1001009,1009003,1,0,03,0,'/web/guest/findResult.aspx?m=1000023'	,N'Find Id & Password'	,N'My Page -&gt; Find Id & Password')
-- SignUp
,(1001010,1010001,1,1,01,0,'/web/guest/signUp.aspx?m=1000025'		,N'Sign up'				,N'My Page -&gt; Sign up')
,(1001010,1010002,1,1,02,0,'/web/guest/signUpOk.aspx?m=1000025'		,N'Sign up'				,N'My Page -&gt; Sign up')
-- Terms & Policy
,(1001011,1011001,1,1,01,0,'/web/policy.aspx?m=1000026&w=18'		,N'Terms of Use'		,N'Home -&gt; Terms of Use')
,(1001011,1011002,1,1,02,0,'/web/policy.aspx?m=1000026&w=19'		,N'Privacy Policy'		,N'Home -&gt; Privacy Policy')
-- Admin. Users
,(1001012,1012001,1,1,01,0,'/web/guest/players.aspx?m=1000018'		,N'User Admin'			,N'User -&gt; User Admin')
,(1001012,1012002,1,1,02,0,'/web/guest/entryStat.aspx?m=1000026'	,N'Signup User Count'	,N'User -&gt; Signup User Count')

KWT001_SG_WS_MENU_LIST:
go

