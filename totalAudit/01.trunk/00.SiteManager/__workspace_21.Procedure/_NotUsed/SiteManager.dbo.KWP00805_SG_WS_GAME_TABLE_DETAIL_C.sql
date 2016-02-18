use SiteManager
go
if object_id('dbo.KWP00805_SG_WS_GAME_TABLE_DETAIL_C') is null
	exec('create procedure dbo.KWP00805_SG_WS_GAME_TABLE_DETAIL_C as select 1')
--	drop procedure dbo.KWP00805_SG_WS_GAME_TABLE_DETAIL_C
go
/******************************************************************************
	name		: dbo.KWP00805_SG_WS_GAME_TABLE_DETAIL_C
	description	: 이벤트 참여자 관리 테이블 필터 저장
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: BLANK parameter
					-3	: delete error
					-4	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-08-13	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00805_SG_WS_GAME_TABLE_DETAIL_C
(	@pTableNo		int
,	@pTableName		varchar(50)
,	@pSeqList		varchar(max)
,	@pColumnName	varchar(max)
,	@pColumnText	nvarchar(max)
,	@pFilterSign	varchar(max)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	if @pTableName = '' or @pColumnText = '' or @pFilterSign = ''
	begin
		set @oReturnNo = -2
		return
	end


	exec LogMasterLive.dbo.KWP00805_LM_WS_GAME_TABLE_DETAIL_C
			@pTableNo		= @pTableNo
		,	@pTableName		= @pTableName
		,	@pSeqList		= @pSeqList
		,	@pColumnName	= @pColumnName
		,	@pColumnText	= @pColumnText
		,	@pFilterSign	= @pFilterSign
		,	@oReturnNo		= @oReturnNo output

	if @@error != 0 or @oReturnNo != 0
		return


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00805_SG_WS_GAME_TABLE_DETAIL_C
 @pTableNo = 1000001
,@pTableName = ''
,@i_seq_list = ''
,@pColumnName = ''
,@pColumnText = ''
,@pFilterSign = ''
,@oReturnNo = @sp output

print @sp
LogMasterLive.dbo.tLogTableTerms
*/
go

grant execute on dbo.KWP00805_SG_WS_GAME_TABLE_DETAIL_C to [opwebuser]
go

