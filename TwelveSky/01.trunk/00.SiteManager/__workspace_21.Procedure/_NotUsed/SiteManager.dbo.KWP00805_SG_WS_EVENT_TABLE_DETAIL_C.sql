use SiteManager
go
if object_id('dbo.KWP00805_SG_WS_EVENT_TABLE_DETAIL_C') is null
	exec('create procedure dbo.KWP00805_SG_WS_EVENT_TABLE_DETAIL_C as select 1')
--	drop procedure dbo.KWP00805_SG_WS_EVENT_TABLE_DETAIL_C
go
/******************************************************************************
	name		: dbo.KWP00805_SG_WS_EVENT_TABLE_DETAIL_C
	description	: 이벤트 참여자 관리 테이블 필터 저장
	reference	:
	result		: @o_return_no
					 0	: Success
					-1	: initialize error
					-2	: BLANK parameter
					-3	: delete error
					-4	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-08-13	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00805_SG_WS_EVENT_TABLE_DETAIL_C
(	@i_table_no		int
,	@i_table_name	varchar(50)
,	@i_seq_no_list	varchar(max)
,	@i_column_name	varchar(max)
,	@i_column_text	nvarchar(max)
,	@i_filter_sign	varchar(max)
,	@o_return_no	int		output

) as
begin
	set nocount on
	set @o_return_no = -1

	if @i_table_name = '' or @i_column_text = '' or @i_filter_sign = ''
	begin
		set @o_return_no = -2
		return
	end


	exec LogMasterLive.dbo.KWP00805_LM_WS_EVENT_TABLE_DETAIL_C
			@i_table_no		= @i_table_no
		,	@i_table_name	= @i_table_name
		,	@i_seq_no_list	= @i_seq_no_list
		,	@i_column_name	= @i_column_name
		,	@i_column_text	= @i_column_text
		,	@i_filter_sign	= @i_filter_sign
		,	@o_return_no	= @o_return_no output

	if @@error != 0 or @o_return_no != 0
		return


	set @o_return_no = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00805_SG_WS_EVENT_TABLE_DETAIL_C
 @i_table_no = 1000001
,@i_table_name = ''
,@i_seq_list = ''
,@i_column_name = ''
,@i_column_text = ''
,@i_filter_sign = ''
,@o_return_no = @sp output

print @sp
LogMasterLive.dbo.tLogTableTerms
*/
go

grant execute on dbo.KWP00805_SG_WS_EVENT_TABLE_DETAIL_C to [opwebuser]
go

