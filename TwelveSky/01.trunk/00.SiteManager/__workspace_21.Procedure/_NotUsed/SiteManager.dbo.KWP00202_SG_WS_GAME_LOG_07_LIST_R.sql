use SiteManager
go
if object_id('dbo.KWP00202_SG_WS_GAME_LOG_07_LIST_R') is null
	exec ('create procedure dbo.KWP00202_SG_WS_GAME_LOG_07_LIST_R as select 1')
--	drop procedure dbo.KWP00202_SG_WS_GAME_LOG_07_LIST_R
go
/******************************************************************************
	name		: KWP00202_SG_WS_GAME_LOG_07_LIST_R
	description	: 게임 로그 영웅관련 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00202_SG_WS_GAME_LOG_07_LIST_R
(	@pServerNo		tinyint
,	@pPlayerNo		bigint
,	@pStartDate		int
,	@pFinishDate	int
,	@pLogType		varchar(25)
,	@pReasonNo		varchar(50)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vSQL	nvarchar(2500)
		,	@vVar	nvarchar(200)
		,	@vLogType_01	char(5)
		,	@vLogType_02	char(5)
		,	@vLogType_03	char(5)
		,	@vReasonNo_01	varchar(25)
		,	@vReasonNo_02	varchar(25)

	select	@vLogType_01 = case cSeqNo when 1 then cValue else @vLogType_01 end
		,	@vLogType_02 = case cSeqNo when 2 then cValue else @vLogType_02 end
		,	@vLogType_03 = case cSeqNo when 3 then cValue else @vLogType_03 end
	from	dbo.fnTbl2String(@pLogType,'|')

	select	@vReasonNo_01 = case cSeqNo when 1 then cValue else @vReasonNo_01 end
		,	@vReasonNo_02 = case cSeqNo when 2 then cValue else @vReasonNo_02 end
	from	dbo.fnTbl2String(@pReasonNo,'|')

	select	@vLogType_01	= replace(@vLogType_01,',','')
		,	@vLogType_02	= replace(@vLogType_02,',','')
		,	@vLogType_03	= replace(@vLogType_03,',','')
	if right(@vReasonNo_01,1) = ',' set @vReasonNo_01 = left(@vReasonNo_01,len(@vReasonNo_01)-1)
	if right(@vReasonNo_02,1) = ',' set @vReasonNo_02 = left(@vReasonNo_02,len(@vReasonNo_02)-1)

	set @vVar = '
			@pServerNo	tinyint
		,	@pPlayerNo	bigint'
	set @vSQL	= '
		select	cWorkDate
			,	cSeqNo
			,	cLogType
			,	cLongInt0
			,	cLongInt1
			,	cInt0
			,	cInt1
			,	cInt2
			,	cCreateTime
		from	LogMasterLive.dbo.tGameLog_07 with(nolock)
		where	cServerNo	= @pServerNo
			and	cAccountNo	= @pPlayerNo
			and	cWorkDate	between '+ rtrim(@pStartDate) +' and '+ rtrim(@pFinishDate) +'
			and	cLogType	in (20009,20010,20011,20059)
			and	(	(	1 = 0)#AND1##AND2##AND3#
			)
		option (recompile)'

	-- 생성 로그 필터링
	if len(@vLogType_01) > 3 and len(@vReasonNo_01) = 0
	begin
		set @vSQL = replace(@vSQL,'#AND1#','
				or	(	cLogType	= '+ @vLogType_01 +'
				)')
	end
	else if len(@vLogType_01) > 3 and len(@vReasonNo_01) > 1
	begin
		set @vSQL = replace(@vSQL,'#AND1#','
				or	(	cLogType	= '+ @vLogType_01 +'
					and	cInt1		in ('+ @vReasonNo_01 +')
				)')
	end

	-- 소멸 로그 필터링
	if len(@vLogType_02) > 3 and len(@vReasonNo_02) = 0
	begin
		set @vSQL = replace(@vSQL,'#AND2#','
				or	(	cLogType	= '+ @vLogType_02 +'
				)')
	end
	else if len(@vLogType_02) > 3 and len(@vReasonNo_02) > 1
	begin
		set @vSQL = replace(@vSQL,'#AND2#','
				or	(	cLogType	= '+ @vLogType_02 +'
					and	cInt1		in ('+ @vReasonNo_02 +')
				)')
	end

	-- 강화 로그 추가
	if len(@vLogType_03) > 3
	begin
		set @vSQL = replace(@vSQL,'#AND3#','
				or	(	cLogType	= '+ @vLogType_03 +'
				)')
	end

	-- 아무 조건도 없을 때 처리
	set @vSQL = replace(@vSQL,'#AND1##AND2##AND3#','
				or	(	1 = 1)')


	-- 조건이 없으면 불필요한 스트링 제거
	set @vSQL = replace(replace(replace(@vSQL,'#AND1#',''),'#AND2#',''),'#AND3#','')
	print @vVar
	print @vSQL
	exec sp_executesql @vSQL
		,	@vVar
		,	@pServerNo
		,	@pPlayerNo

	if @@error != 0
	begin
		set @oReturnNo = -3
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @SP int
exec dbo.KWP00202_SG_WS_GAME_LOG_07_LIST_R
 @pServerNo = 1
,@pPlayerNo = 337164
,@pStartDate = 20130620
,@pFinishDate = 20130620
,@pLogType = ''
,@pReasonNo = ''
,@oReturnNo = @SP output

print @SP
*/
go

grant execute on dbo.KWP00202_SG_WS_GAME_LOG_07_LIST_R to [opwebuser]
go

