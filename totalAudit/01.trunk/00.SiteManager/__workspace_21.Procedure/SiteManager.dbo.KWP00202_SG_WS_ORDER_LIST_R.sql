use SiteManager
go
if object_id('dbo.KWP00202_SG_WS_ORDER_LIST_R') is null
	exec ('create procedure dbo.KWP00202_SG_WS_ORDER_LIST_R as select 1')
--	drop procedure dbo.KWP00202_SG_WS_ORDER_LIST_R
go
/******************************************************************************
	name		: KWP00202_SG_WS_ORDER_LIST_R
	description	: 주문번호에 해당하는 유저번호 찾기
	reference	:
	result		: @oReturnNo
					 0	: Success
					 1	: 검색된 유저번호 없음
					-1	: initialize error
					-2	: 주문번호 오류
					-3	: 검색 오류

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2014-03-03	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00202_SG_WS_ORDER_LIST_R
(	@pOrderNo		varchar(max)
,	@pStartDate		int
,	@pFinishDate	int
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	distinct
			cWorkDate
		,	cText4 as cOrderNo
	from	dbo.fnTbl2NString(@pOrderNo,char(10)) as a
			inner join
			LogMasterLive.dbo.tGameLog_15 as b with(nolock)
		on	b.cText4	= a.cValue
	where	cLogType	= 20050
		and	cWorkDate	between @pStartDate and @pFinishDate
	order by cOrderNo
	option (recompile)


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00202_SG_WS_ORDER_LIST_R
 @pOrderNo = '504216529694760
465960356849418
491951160917002
479735758805213
479766065468849
491512680960857
479766138802175
485191728259617
523872161062276
518841124896024'
,@pStartDate = '20130301'
,@pFinishDate = '20140302'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00202_SG_WS_ORDER_LIST_R to [opwebuser]
go

