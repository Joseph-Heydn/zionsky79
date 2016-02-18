use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_ACTION_LOG_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_ACTION_LOG_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_ACTION_LOG_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_ACTION_LOG_C
	Description	: 관리자 작업 로그 생성
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_ACTION_LOG_C
(	@pGameNo		int
,	@pAccountNo		int
,	@pMenuNo		int
,	@pProcedure		varchar(80)
,	@pResult		int
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_ACTION_LOG
		(	cWorkDate
		,	cGameNo
		,	cAccountNo
		,	cMenuNo
		,	cProcedure
		,	cResult
		,	cHostIp
		,	cCreateTime
		)
	values
		(	convert(char(8),@vGetDate,112)
		,	@pGameNo
		,	@pAccountNo
		,	@pMenuNo
		,	@pProcedure
		,	@pResult
		,	@pHostIp
		,	@vGetDate
		)

	if @@rowcount = 0
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
exec dbo.KWP00105_SG_WS_ACTION_LOG_C
 @pGameNo = 20150001
,@pAccountNo = 100000001
,@pMenuNo = 1009002
,@pProcedure = 'KWP00105_SG_WS_ADMIN_LOG_C'
,@pResult = 0
,@pHostIp = '127.0.0.1'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_ACTION_LOG_C to [opwebuser]
go

