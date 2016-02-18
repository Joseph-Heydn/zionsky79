use SiteManager
go
if object_id('dbo.KWP00202_SG_WS_GAME_LOG_06_LIST_R') is null
	exec ('create procedure dbo.KWP00202_SG_WS_GAME_LOG_06_LIST_R as select 1')
--	drop procedure dbo.KWP00202_SG_WS_GAME_LOG_06_LIST_R
go
/******************************************************************************
	name		: KWP00202_SG_WS_GAME_LOG_06_LIST_R
	description	: 게임 로그 재화 획득/소모 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00202_SG_WS_GAME_LOG_06_LIST_R
(	@pServerNo		tinyint
,	@pPlayerNo		bigint
,	@pStartDate		int
,	@pFinishDate	int
,	@pLogType		varchar(40)
,	@pReasonNo		varchar(50)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vSQL	nvarchar(2700)
		,	@vVar	nvarchar(200)
		,	@vLogType_01	varchar(30) = ''
		,	@vLogType_02	varchar(30) = ''
		,	@vReasonNo_01	varchar(25) = ''
		,	@vReasonNo_02	varchar(25) = ''

	select	@vLogType_01 = case cSeqNo when 1 then cValue else @vLogType_01 end
		,	@vLogType_02 = case cSeqNo when 2 then cValue else @vLogType_02 end
	from	dbo.fnTbl2String(@pLogType,'|')

	select	@vReasonNo_01 = case cSeqNo when 1 then cValue else @vReasonNo_01 end
		,	@vReasonNo_02 = case cSeqNo when 2 then cValue else @vReasonNo_02 end
	from	dbo.fnTbl2String(@pReasonNo,'|')

	if right(@vLogType_01,1)	= ',' set @vLogType_01	= left(@vLogType_01,len(@vLogType_01)-1)
	if right(@vLogType_02,1)	= ',' set @vLogType_02	= left(@vLogType_02,len(@vLogType_02)-1)
	if right(@vReasonNo_01,1) = ',' set @vReasonNo_01	= left(@vReasonNo_01,len(@vReasonNo_01)-1)
	if right(@vReasonNo_02,1) = ',' set @vReasonNo_02	= left(@vReasonNo_02,len(@vReasonNo_02)-1)

	set @vVar = '
			@pServerNo	tinyint
		,	@pPlayerNo	bigint'
	set @vSQL	= '
		select	cWorkDate
			,	cSeqNo
			,	cLogType
			,	cLongInt0
			,	cInt0
			,	cInt1
			,	cInt2
			,	cInt3
			,	cInt4
			,	cCreateTime
		from	LogMasterLive.dbo.tGameLog_06 with(nolock)
		where	cServerNo	= @pServerNo
			and	cAccountNo	= @pPlayerNo
			and	cInt0		!= 0#AND1##AND2#
			and	cWorkDate	between '+ rtrim(@pStartDate) +' and '+ rtrim(@pFinishDate) +'
		option (recompile)'

	-- 획득/소모 분류 코드만 들어온 경우
	if len(@vLogType_01) > 3 and len(@vLogType_02) > 3 and len(@vReasonNo_01) = 0 and len(@vReasonNo_02) = 0
	begin
		set @vSQL = replace(@vSQL,'#AND1##AND2#','
			and	cLogType	in ('+ @vLogType_01 +','+ @vLogType_02 +')')
	end


	-- 획들/소모 분퓨 코드가 들어오고 이유 코드가 한쪽에만 들어온 경우
	if len(@vLogType_01) > 3 and len(@vReasonNo_01) > 1 and len(@vLogType_02) > 3 and len(@vReasonNo_02) = 0
	begin
		set @vSQL = replace(@vSQL,'#AND1##AND2#','
			and	(	(	cLogType	in ('+ @vLogType_01	+')
					and	cLongInt0	in ('+ @vReasonNo_01	+')
				)
				or	(	cLogType	in ('+ @vLogType_02	+')
				)
			)')
	end
	else if len(@vLogType_01) > 3 and len(@vReasonNo_01) = 0 and len(@vLogType_02) > 3 and len(@vReasonNo_02) > 1
	begin
		set @vSQL = replace(@vSQL,'#AND1##AND2#','
			and	(	(	cLogType	in ('+ @vLogType_01	+')
				)
				or	(	cLogType	in ('+ @vLogType_02	+')
					and	cLongInt0	in ('+ @vReasonNo_02	+')
				)
			)')
	end


	-- 획득 분류 코드만 들어온 경우
	if len(@vLogType_01) > 3 and len(@vReasonNo_01) = 0
	begin
		set @vSQL = replace(@vSQL,'#AND1#','
			and	cLogType	in ('+ @vLogType_01 +')')
	end
	-- 소모 분류 코드만 들어온 경우
	if len(@vLogType_02) > 3 and len(@vReasonNo_02) = 0
	begin
		set @vSQL = replace(@vSQL,'#AND2#','
			and	cLogType	in ('+ @vLogType_02 +')')
	end


	-- 획득/소모 분류, 이유 코드가 모두 들어온 경우
	if len(@vLogType_01) > 3 and len(@vLogType_02) > 1
	begin
		set @vSQL = replace(@vSQL,'#AND1##AND2#','
			and	(	(	cLogType	in ('+ @vLogType_01	+')
					and	cLongInt0	in ('+ @vReasonNo_01	+')
				)
				or	(	cLogType	in ('+ @vLogType_02	+')
					and	cLongInt0	in ('+ @vReasonNo_02	+')
				)
			)')
	end

	-- 획득/소모 분류, 이유 코드 중 한쪽 세트만 들어온 경우
	if len(@vLogType_01) > 3 and len(@vReasonNo_01) > 1
	begin
		set @vSQL = replace(@vSQL,'#AND1#','
			and	cLogType	in ('+ @vLogType_01	+')
			and	cLongInt0	in ('+ @vReasonNo_01	+')')
	end
	else if len(@vLogType_02) > 3 and len(@vReasonNo_02) > 1
	begin
		set @vSQL = replace(@vSQL,'#AND2#','
			and	cLogType	in ('+ @vLogType_02	+')
			and	cLongInt0	in ('+ @vReasonNo_02	+')')
	end


	set @vSQL = replace(replace(@vSQL,'#AND1#',''),'#AND2#','')
	print @vSQL
	print @vVar
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
exec dbo.KWP00202_SG_WS_GAME_LOG_06_LIST_R
 @pServerNo = 2
,@pPlayerNo = 519026
,@pStartDate = 20130501
,@pFinishDate = 20130515
,@pLogType = ''
,@pReasonNo = ''
,@oReturnNo = @SP output

print @SP
*/
go

--grant select on dbo.tGameLog_06 to [opwebuser]
--grant select on dbo.TBL_LOG_TYPE_MST to [opwebuser]
grant execute on dbo.KWP00202_SG_WS_GAME_LOG_06_LIST_R to [opwebuser]
go

