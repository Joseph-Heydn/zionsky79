use SiteManager
go
if object_id('dbo.KWP00802_SG_WS_GAME_TABLE_RESULT_LIST_R') is null
	exec('create procedure dbo.KWP00802_SG_WS_GAME_TABLE_RESULT_LIST_R as select 1')
--	drop procedure dbo.KWP00802_SG_WS_GAME_TABLE_RESULT_LIST_R
go
/******************************************************************************
	name		: dbo.KWP00802_SG_WS_GAME_TABLE_RESULT_LIST_R
	description	: 로그 관리 테이블 상세 내역 & 샘플 테이터
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00802_SG_WS_GAME_TABLE_RESULT_LIST_R
(	@pTableNo		int
,	@pTableName		varchar(50)
,	@pSeqList		varchar(2000)
,	@pFilterList	varchar(4000)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	exec LogMasterLive.dbo.KWP00802_LM_WS_GAME_TABLE_RESULT_LIST_R
			@pTableNo		= @pTableNo
		,	@pTableName		= @pTableName
		,	@pSeqList		= @pSeqList
		,	@pFilterList	= @pFilterList
		,	@oReturnNo		= @oReturnNo output

	if @@error != 0 or @oReturnNo != 0
		return


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00802_SG_WS_GAME_TABLE_RESULT_LIST_R
 @pTableNo = 1000001
,@pTableName = 'tGameLog_01'
,@pSeqList = '3|'
,@pFilterList = '2015|'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00802_SG_WS_GAME_TABLE_RESULT_LIST_R to [opwebuser]
go

