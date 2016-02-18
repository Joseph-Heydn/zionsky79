use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_EVENT_COMBINE_INFO_C') is null
	exec('create procedure dbo.KWP00305_SG_WS_EVENT_COMBINE_INFO_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_EVENT_COMBINE_INFO_C
go
/******************************************************************************
	name		: KWP00305_SG_WS_EVENT_COMBINE_INFO_C
	description	: 이벤트 조합 목록
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_EVENT_COMBINE_INFO_C
(	@pServerNo		tinyint
,	@pEventType		bit
,	@pEventName		nvarchar(16)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	if exists (
		select	top 1 1
		from	dbo.KWT003_SG_WS_EVENT_COMBINE with(updlock)
		where	cEventType	= @pEventType
			and	cEventName	= @pEventName
	)
	begin
		set @oReturnNo = -2
		return
	end


	insert into dbo.KWT003_SG_WS_EVENT_COMBINE
		(	cEventNo
		,	cEventType
		,	cEventName
		,	cCreateTime
		)
	select	isnull(max(cEventNo),0) + 1
		,	@pEventType
		,	@pEventName
		,	getdate()
	from	dbo.KWT003_SG_WS_EVENT_COMBINE with(nolock)

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
declare @sp int
exec dbo.KWP00305_SG_WS_EVENT_COMBINE_INFO_C
 @pServerNo = 1
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00305_SG_WS_EVENT_COMBINE_INFO_C to [opwebuser]
go

