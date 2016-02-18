use SiteManager
go
if object_id('dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R') is null
	exec ('create procedure dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R as select 1')
--	drop procedure dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R
go
/******************************************************************************
	name		: KWP00204_SG_WS_ORDER_ACCOUNT_R
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
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R
(	@pServerNo		tinyint
,	@pOrderNo		varchar(64)
,	@pStartDate		int
,	@pFinishDate	int
,	@oPlayerNo		bigint	output
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vSQL nvarchar(400)
		,	@vVar nvarchar(200)
	select	@oReturnNo = -1
		,	@oPlayerNo = 0

	if len(@pOrderNo) < 35
	begin
		set @oReturnNo = -2
		return
	end


	set @vVar = '
			@pOrderNo		nvarchar(64)
		,	@pServerNo		tinyint
		,	@pStartDate		int
		,	@pFinishDate	int
		,	@oPlayerNo		bigint	output'
	set @vSQL = '
		select	top 1
				@oPlayerNo	= cAccountNo
		from	LogMasterLive.dbo.tGameLog_15 with(nolock)
		where	cText4		= @pOrderNo
			and	cServerNo	= @pServerNo
			and	cLogType	= 20053
			and	cWorkDate	between @pStartDate and @pFinishDate
		option (recompile)'

	print @vVar
	print @vSQL
	exec sp_executesql @vSQL
		,	@vVar
		,	@pOrderNo
		,	@pServerNo
		,	@pStartDate
		,	@pFinishDate
		,	@oPlayerNo	output

	if @@error != 0
	begin
		set @oReturnNo = -3
		return
	end


	if isnull(@oPlayerNo,0) = 0
	begin
		set @oReturnNo = 1
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @p1 bigint
,@sp int
exec dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R
 @pServerNo = 1
,@pOrderNo = '12999763169054705758.1376548775089802'
,@pStartDate = '2014-01-01'
,@pFinishDate = '2014-02-01'
,@oPlayerNo = @p1 output
,@oReturnNo = @sp output

print @p1
print @sp
*/
go

grant execute on dbo.KWP00204_SG_WS_ORDER_ACCOUNT_R to [opwebuser]
go

