use SiteManager
go
if object_id('dbo.KWP00802_SG_WS_EVENT_TABLE_FILTER_LIST_R') is null
	exec('create procedure dbo.KWP00802_SG_WS_EVENT_TABLE_FILTER_LIST_R as select 1')
--	drop procedure dbo.KWP00802_SG_WS_EVENT_TABLE_FILTER_LIST_R
go
/******************************************************************************
	name		: dbo.KWP00802_SG_WS_EVENT_TABLE_FILTER_LIST_R
	description	: 로그 테이블 필터 리스트 & 샘플 테이터
	reference	:
	result		: @o_return_no
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00802_SG_WS_EVENT_TABLE_FILTER_LIST_R
(	@i_table_no		int
,	@i_table_name	varchar(50)
,	@o_return_no	int		output

) as
begin
	set nocount on
	set @o_return_no = -1

	exec LogMasterLive.dbo.KWP00802_LM_WS_EVENT_TABLE_FILTER_LIST_R
			@i_table_no		= @i_table_no
		,	@i_table_name	= @i_table_name
		,	@o_return_no	= @o_return_no output

	if @@error != 0 or @o_return_no != 0
		return


	set @o_return_no = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00802_SG_WS_EVENT_TABLE_FILTER_LIST_R
 @i_table_no = 1000001
,@i_table_name = 'tGameLog_01'
,@o_return_no = @sp output

print @sp
*/
go

grant execute on dbo.KWP00802_SG_WS_EVENT_TABLE_FILTER_LIST_R to [opwebuser]
go

