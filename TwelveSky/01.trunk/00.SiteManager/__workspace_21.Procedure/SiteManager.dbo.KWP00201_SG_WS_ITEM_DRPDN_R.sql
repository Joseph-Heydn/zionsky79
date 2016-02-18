use SiteManager
go
if object_id('dbo.KWP00201_SG_WS_ITEM_DRPDN_R') is null
	exec ('create procedure dbo.KWP00201_SG_WS_ITEM_DRPDN_R as select 1')
--	drop procedure dbo.KWP00201_SG_WS_ITEM_DRPDN_R
go
/******************************************************************************
	Name		: dbo.KWP00201_SG_WS_ITEM_DRPDN_R
	Description	: 아이템/영웅 드롭다운 리스트
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-12	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00201_SG_WS_ITEM_DRPDN_R
(	@oReturnNo	int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cSeqNo
	from	dbo.KWT002_SG_WS_SEQ_LIST with(nolock)
	where	cSeqNo < 700


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00201_SG_WS_ITEM_DRPDN_R
@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00201_SG_WS_ITEM_DRPDN_R to [opwebuser]
go

