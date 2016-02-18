use SiteManager
go
if object_id('dbo.KWP00205_SG_WS_GOODS_LOG_C') is null
	exec ('create procedure dbo.KWP00205_SG_WS_GOODS_LOG_C as select 1')
--	drop procedure dbo.KWP00205_SG_WS_GOODS_LOG_C
go
/******************************************************************************
	name		: dbo.KWP00205_SG_WS_GOODS_LOG_C
	description	: 선물 지급 및 인벤토리 수정
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: Insert error

		@pAction
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

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-04-15	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00205_SG_WS_GOODS_LOG_C
(	@pServerNo		int				-- 서버 번호
,	@pPlayerNo		bigint			-- 유저 번호
,	@pPublisher		tinyint			-- 퍼블리셔 번호
,	@pMailNo		bigint			-- 선물 번호
,	@pNickName		nvarchar(16)	-- 닉네임
,	@pAction		varchar(99)		-- 선물 타입
,	@pValueOld		varchar(99)		-- 선물 값
,	@pValueNew		varchar(99)		-- 이전 값
,	@pAdminNo		int				-- 관리자 번호
,	@pHostIp		varchar(15)		-- 아이피 주소
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vWorkDate int
		,	@vGetDate datetime = getdate()
	select	@oReturnNo	= -1
		,	@pMailNo	= nullif(@pMailNo,0)
		,	@vWorkDate	= convert(char(8),getdate(),112)

	insert into dbo.KWT002_SG_WS_GOODS_LOG
		(	cWorkDate
		,	cServerNo
		,	cPlayerNo
		,	cNickName
		,	cPublisher
		,	cMailNo
		,	cAction
		,	cValueNew
		,	cValueOld
		,	cTryCnt
		,	cAdminNo
		,	cHostIp
		,	cCreateTime
		)
	select	@vWorkDate
		,	@pServerNo
		,	@pPlayerNo
		,	@pNickName
		,	@pPublisher
		,	isnull(@pMailNo,1)
		,	a.cValue
		,	convert(numeric(19,11),convert(float,b.cValue))
		,	convert(numeric(19,11),convert(float,c.cValue))
		,	1
		,	@pAdminNo
		,	@pHostIp
		,	@vGetDate
	from	dbo.fnTbl2Int(@pAction,'|')			as a
			inner join
			dbo.fnTbl2String(@pValueNew,'|')	as b
		on	b.cSeqNo	= a.cSeqNo
			inner join
			dbo.fnTbl2String(@pValueOld,'|')	as c
		on	c.cSeqNo	= a.cSeqNo
	where	a.cValue	> ''

	if @@error != 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00205_SG_WS_GOODS_LOG_C
 @pServerNo = 1
,@pPlayerNo = 337164
,@pNickName = '노리타'
,@pPublisher = 89246305501125009
,@pAction = 3
,@pValueOld = 100
,@pValueNew = 150
,@pAdminNo = 100000001
,@pHostIp = '222.117.240.137'
,@oReturnNo = @sp output

print @sp


truncate table dbo.KWT002_SG_WS_GOODS_LOG
*/
go

grant execute on dbo.KWP00205_SG_WS_GOODS_LOG_C to [opwebuser]

