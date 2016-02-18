use SiteManager
go
if object_id('dbo.KWP00307_SG_WS_EVENT_TABLE_U') is null
	exec('create procedure dbo.KWP00307_SG_WS_EVENT_TABLE_U as select 1')
--	drop procedure dbo.KWP00307_SG_WS_EVENT_TABLE_U
go
/******************************************************************************
	name		: KWP00307_SG_WS_EVENT_TABLE_U
	description	: 이벤트 참여자 관리 테이블 조건 추가
	reference	:
	result		: @o_return_no
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-08-13	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00307_SG_WS_EVENT_TABLE_U
(	@i_table_no		int
,	@i_table_desc	nvarchar(16)
,	@i_use_flag		bit
,	@o_return_no	int		output

) as
begin
	set nocount on
	set @o_return_no = -1

	update	A
	set		event_name	= @i_table_desc
		,	use_flag	= @i_use_flag
	from	dbo.KWT003_SG_WS_EVENT_TABLE as A
	where	table_no	= @i_table_no


	set @o_return_no = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00307_SG_WS_EVENT_TABLE_U
 @i_table_no = 1000001
,@i_table_name = ''
,@i_table_desc = ''
,@i_use_flag = 1
,@o_return_no = @sp output

print @sp
*/
go

grant execute on dbo.KWP00307_SG_WS_EVENT_TABLE_U to [opwebuser]
go

