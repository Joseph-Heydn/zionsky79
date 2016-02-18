use SiteManager
go
if object_id('dbo.KWP00307_SG_WS_EVENT_PRESENT_INFO_U') is null
	exec('create procedure dbo.KWP00307_SG_WS_EVENT_PRESENT_INFO_U as select 1')
--	drop procedure dbo.KWP00307_SG_WS_EVENT_PRESENT_INFO_U
go
/******************************************************************************
	name		: KWP00307_SG_WS_EVENT_PRESENT_INFO_U
	description	: 이벤트 기본 정보 리스트
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: UPDATE error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00307_SG_WS_EVENT_PRESENT_INFO_U
(	@pEventNo		int
,	@pEventName		nvarchar(16)
,	@pNoteText		nvarchar(50)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	update	a
	set		cEventName	= @pEventName
		,	cNoteText	= @pNoteText
	from	dbo.KWT003_SG_WS_EVENT_PRESENT as a
	where	cEventNo	= @pEventNo

	if @@error != 0 or @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00307_SG_WS_EVENT_PRESENT_INFO_U
 @pServerNo = 1
,@pEventType = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00307_SG_WS_EVENT_PRESENT_INFO_U to [opwebuser]
go

