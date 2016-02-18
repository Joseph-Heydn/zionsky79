use SiteManager
go
if object_id('dbo.KWP00302_SG_WS_EVENT_TABLE_LIST_R') is null
	exec('create procedure dbo.KWP00302_SG_WS_EVENT_TABLE_LIST_R as select 1')
--	drop procedure dbo.KWP00302_SG_WS_EVENT_TABLE_LIST_R
go
/******************************************************************************
	name		: KWP00302_SG_WS_EVENT_TABLE_LIST_R
	description	: 이벤트 참여자 관리 테이블 내역
	reference	:
	result		: @o_return_no
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-08-12	Hoon-Sik,Jin	1.CREATE
	2.0		2014-03-11	Hoon-Sik,Jin	1.@i_table_type 추가
******************************************************************************/
alter procedure dbo.KWP00302_SG_WS_EVENT_TABLE_LIST_R
(	@i_table_type	tinyint
,	@o_return_no	int		output

) as
begin
	set nocount on
	declare	@v_start_no		int
		,	@v_finish_no	int
	set @o_return_no = -1

	-- 참여자 조회
	if @i_table_type = 1
		select	@v_start_no		= 1000001
			,	@v_finish_no	= 2000000
	-- 로그 뷰어
	else if @i_table_type = 2
		select	@v_start_no		= 2000001
			,	@v_finish_no	= 3000000

	select	table_no
		,	table_name
		,	event_name
		,	use_flag
		,	ipt_time
	from	dbo.KWT003_SG_WS_EVENT_TABLE with(nolock)
	where	table_no between @v_start_no and @v_finish_no
	order by table_no


	set @o_return_no = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00302_SG_WS_EVENT_TABLE_LIST_R
 @i_table_type = 1
,@o_return_no = @sp output

print @sp
*/
go

grant execute on dbo.KWP00302_SG_WS_EVENT_TABLE_LIST_R to [opwebuser]
go

