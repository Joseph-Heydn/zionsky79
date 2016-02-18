use SiteManager
go
if object_id('dbo.KWP00304_SG_WS_EVENT_PRESENT_INFO_R') is null
	exec('create procedure dbo.KWP00304_SG_WS_EVENT_PRESENT_INFO_R as select 1')
--	drop procedure dbo.KWP00304_SG_WS_EVENT_PRESENT_INFO_R
go
/******************************************************************************
	name		: KWP00304_SG_WS_EVENT_PRESENT_INFO_R
	description	: 이벤트 선물 내용
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00304_SG_WS_EVENT_PRESENT_INFO_R
(	@pEventNo		int
,	@oNoteText		nvarchar(50)	output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	@oNoteText	= cNoteText
	from	dbo.KWT003_SG_WS_EVENT_PRESENT with(nolock)
	where	cEventNo	= @pEventNo


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 nvarchar(100)
,@sp int
exec dbo.KWP00304_SG_WS_EVENT_PRESENT_INFO_R
 @pEventNo = 1000000004
,@oNoteText = @o1 output
,@oReturnNo = @sp output

print @o1
print @sp
*/
go

grant execute on dbo.KWP00304_SG_WS_EVENT_PRESENT_INFO_R to [opwebuser]
go

