use SiteManager
go
if object_id('dbo.KWT002_SG_WS_GOODS_LOG') is not null
begin
	print N'dbo.KWT002_SG_WS_GOODS_LOG 테이블이 존재 합니다.'
	goto KWT002_SG_WS_GOODS_LOG
	/**
		alter sequence dbo.sGoodsLog restart with 1
		truncate table dbo.KWT002_SG_WS_GOODS_LOG
		drop table dbo.KWT002_SG_WS_GOODS_LOG
	**/
end

create table dbo.KWT002_SG_WS_GOODS_LOG
(	cLogs			bigint			not null
,	cWorkDate		int				not null
,	cServerNo		tinyint			not null
,	cPlayerNo		bigint			not null
,	cNickName		nvarchar(12)	not null
,	cPublisher		bigint			not null
,	cMailNo			bigint			not null
,	cAction			tinyint			not null
,	cValueNew		numeric(19,11)	not null
,	cValueOld		numeric(19,11)	not null
,	cTryCnt			smallint		not null
,	cAdminNo		int				not null
,	cHostIp			varchar(15)		not null
,	cModifyTime		datetime			null
,	cCreateTime		datetime		not null
)

/*
cAction
	-- 선물
	01	: 명예 지급
	02	: 골드 지급
	03	: 캐럿 지급
	04	: 스테미나 지급
	05	: 에너지 지급
	06	: 지정 영웅 지급
	07	: 지정 아이템 지급
	08	: 랜덤 영웅 지급
	09	: 랜덤 아이템 지급

	21	: 명예 회수
	22	: 골드 회수
	23	: 캐럿 회수
	24	: 스테미나 회수
	25	: 에너지 회수
	26	: 지정 영웅 회수
	27	: 지정 아이템 회수
	28	: 랜덤 영웅 회수
	29	: 랜덤 아이템 회수

	-- 확장 속성
	61	: 4배속 만료 시간 증가
	62	: 경험치 부스터 만료 시간 증가
	63	: 타임어택 키 증가
	64	: 타임어택 만료 시간 증가

	71	: 4배속 만료 시간 감소
	72	: 경험치 부스터 만료 시간 감소
	73	: 타임어택 키 감소
	74	: 타임어택 만료 시간 감소

	-- 인벤 수치 변경
	81	: 명예 지급
	82	: 골드 지급
	83	: 캐럿 지급
	84	: 스테미나 지급
	85	: 에너지 지급
	103	: 보상 캐럿 지급
	121	: 캐럿 포인트 지급

	91	: 명예 회수
	92	: 골드 회수
	93	: 캐럿 회수
	94	: 스테미나 회수
	95	: 에너지 회수
	113	: 보상 캐럿 회수
	131	: 캐럿 포인트 회수
*/

-- alter table dbo.KWT002_SG_WS_GOODS_LOG drop constraint PK_KWT002_SG_WS_GOODS_LOG_01
alter table dbo.KWT002_SG_WS_GOODS_LOG
add constraint PK_KWT002_SG_WS_GOODS_LOG_01
primary key clustered
(	cLogs desc
)

-- drop index KWT002_SG_WS_GOODS_LOG.IX_KWT002_SG_WS_GOODS_LOG_02
create nonclustered index IX_KWT002_SG_WS_GOODS_LOG_02
ON	dbo.KWT002_SG_WS_GOODS_LOG
(	cPlayerNo
,	cWorkDate
)

-- drop index KWT002_SG_WS_GOODS_LOG.IX_KWT002_SG_WS_GOODS_LOG_02
create nonclustered index IX_KWT002_SG_WS_GOODS_LOG_03
ON	dbo.KWT002_SG_WS_GOODS_LOG
(	cPublisher
,	cWorkDate
)

alter table dbo.KWT002_SG_WS_GOODS_LOG add constraint DF_KWT002_SG_WS_GOODS_LOG_01 default(next value for dbo.sGoodsLog) for cLogs

KWT002_SG_WS_GOODS_LOG:
go

