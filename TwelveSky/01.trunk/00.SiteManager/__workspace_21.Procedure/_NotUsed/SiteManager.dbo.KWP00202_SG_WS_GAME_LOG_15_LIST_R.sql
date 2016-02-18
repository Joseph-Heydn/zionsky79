use SiteManager
go
if object_id('dbo.KWP00202_SG_WS_GAME_LOG_15_LIST_R') is null
	exec ('create procedure dbo.KWP00202_SG_WS_GAME_LOG_15_LIST_R as select 1')
--	drop procedure dbo.KWP00202_SG_WS_GAME_LOG_15_LIST_R
go
/******************************************************************************
	name		: KWP00202_SG_WS_GAME_LOG_15_LIST_R
	description	: 게임 로그 결제정보 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00202_SG_WS_GAME_LOG_15_LIST_R
(	@pServerNo		tinyint
,	@pPlayerNo		bigint
,	@pStartDate		int
,	@pFinishDate	int
,	@pLogType		varchar(20)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vSQL nvarchar(2500)
		,	@vVar nvarchar(200)
	if right(@pLogType,1) = ',' set @pLogType = left(@pLogType,len(@pLogType)-1)

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
			,	cText4
			,	cText5
			,	cCreateTime
		from	LogMasterLive.dbo.tGameLog_15 with(nolock)
		where	cServerNo	= @pServerNo
			and	cAccountNo	= @pPlayerNo
			and	cLongInt0	!= 0#AND#
			and	cWorkDate	between '+ rtrim(@pStartDate) +' and '+ rtrim(@pFinishDate) +'
		option (recompile)'

	if len(@pLogType) > 1
		set @vSQL = replace(@vSQL,'#AND#','
			and cLogType	in ('+ @pLogType +')')

	set @vSQL = replace(@vSQL,'#AND#','')
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
exec dbo.KWP00202_SG_WS_GAME_LOG_15_LIST_R
 @pServerNo = 1
,@pPlayerNo = 109511
,@pStartDate = 20130318
,@pFinishDate = 20130318
,@pLogType = 0
,@oReturnNo = @SP output

print @SP
*/
go

grant execute on dbo.KWP00202_SG_WS_GAME_LOG_15_LIST_R to [opwebuser]
go

