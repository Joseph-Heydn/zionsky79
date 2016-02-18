use SiteManager
go
if object_id('dbo.KWP00301_SG_WS_EVENT_TABLE_DRPDN_R') is null
	exec('create procedure dbo.KWP00301_SG_WS_EVENT_TABLE_DRPDN_R as select 1')
--	drop procedure dbo.KWP00301_SG_WS_EVENT_TABLE_DRPDN_R
go
/******************************************************************************
	name		: KWP00301_SG_WS_EVENT_TABLE_DRPDN_R
	description	: 이벤트 참여자 테이블 리스트
	reference	:
	result		: @o_return_no
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-08-13	Hoon-Sik,Jin	1.CREATE
	2.0		2014-03-11	Hoon-Sik,Jin	1.@i_table_type 추가
******************************************************************************/
alter procedure dbo.KWP00301_SG_WS_EVENT_TABLE_DRPDN_R
(	@i_table_type	tinyint
,	@o_return_no	int		output

) as
begin
	set nocount on
	declare	@v_start_no		int
		,	@v_finish_no	int
	set @o_return_no = -1

	if @i_table_type = 1
		select	@v_start_no		= 1000001
			,	@v_finish_no	= 2000000
	else if @i_table_type = 2
		select	@v_start_no		= 2000001
			,	@v_finish_no	= 3000000

	select	rtrim(table_no) +'|'+ table_name as table_no
		,	event_name
	from	dbo.KWT003_SG_WS_EVENT_TABLE with(nolock)
	where	table_no between @v_start_no and @v_finish_no
		and	use_flag = 1
	order by event_name


	set @o_return_no = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00301_SG_WS_EVENT_TABLE_DRPDN_R
@o_return_no = @sp output

print @sp
*/
go

grant execute on dbo.KWP00301_SG_WS_EVENT_TABLE_DRPDN_R to [opwebuser]
go

