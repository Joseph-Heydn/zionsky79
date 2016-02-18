use SiteManager
go
if object_id('dbo.KWP00602_SG_WS_STATIS_SALES_CARAT_LIST_R') is null
	exec ('create procedure dbo.KWP00602_SG_WS_STATIS_SALES_CARAT_LIST_R as select 1')
--	drop procedure dbo.KWP00602_SG_WS_STATIS_SALES_CARAT_LIST_R
go
/******************************************************************************
	name		: KWP00602_SG_WS_STATIS_SALES_CARAT_LIST_R
	description	: Active User List
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-04-06	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00602_SG_WS_STATIS_SALES_CARAT_LIST_R
(	@pServerNo		tinyint
,	@pStartDate		int
,	@pFinishDate	int
,	@oProductNo		tinyint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -1

	select	@oProductNo	= isnull(max(cProductNo),0) + 1
	from	LogMasterLive.dbo.tStatisticsSalesCarat
	where	cWorkDate	between @pStartDate and @pFinishDate


	select	cProductNo
	into	#tmpCaratTypeList
	from	LogMasterLive.dbo.tStatisticsSalesCarat
	where	cWorkDate	between @pStartDate and @pFinishDate

	if @pStartDate = @pFinishDate
	begin
		-- 하루: 전체서버 상품 타입별 합계
		select	left(a.cTime,2) +':'+ right(a.cTime,2) as cWorkDate
			,	a.cProductNo
			,	isnull(cBuyCnt,0) as cBuyCnt
		from	(	select	a.cServerNo
						,	b.cProductNo
						,	a.cTime
					from	LogMasterLive.dbo.tConcurrentTimeMaster as a
							CROSS JOIN #tmpCaratTypeList as b
				) as a
				left outer join
				LogMasterLive.dbo.tStatisticsSalesCarat	as b
			on	b.cWorkDate		= @pStartDate
			and	b.cServerNo		= a.cServerNo
			and	b.cProductNo	= a.cProductNo
			and	b.cBuyTime		= a.cTime
		where	a.cServerNo		= @pServerNo
		order by
				a.cProductNo
			,	a.cTime
	end
	else
	begin
		-- 기간: 서버별 상품 타입별 합계
		select	a.cWorkDate
			,	a.cProductNo
			,	isnull(sum(cBuyCnt),0) as cBuyCnt
		from	(	select	distinct
							a.cWorkDate
						,	a.cServerNo
						,	b.cProductNo
					from	LogMasterLive.dbo.tWorkDateMaster as a
							CROSS JOIN #tmpCaratTypeList as b
				) as a
				left outer join
				LogMasterLive.dbo.tStatisticsSalesCarat	as b
			on	b.cWorkDate		= a.cWorkDate
			and	b.cServerNo		= a.cServerNo
			and	b.cProductNo	= a.cProductNo
		where	a.cWorkDate		between @pStartDate and @pFinishDate
			and	a.cServerNo		= @pServerNo
		group by
				a.cWorkDate
			,	a.cProductNo
		order by
				a.cProductNo
			,	a.cWorkDate
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 tinyint
,@sp int
exec dbo.KWP00602_SG_WS_STATIS_SALES_CARAT_LIST_R
 @pServerNo = 0
,@pStartDate = 20140603
,@pFinishDate = 20140615
,@oProductNo = @o1 output
,@oReturnNo = @sp output

print @o1
print @sp
*/
go

grant execute on dbo.KWP00602_SG_WS_STATIS_SALES_CARAT_LIST_R to [opwebuser]
go

