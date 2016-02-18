use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_ADMIN_LOG_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_ADMIN_LOG_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_ADMIN_LOG_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_ADMIN_LOG_C
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
alter procedure dbo.KWP00105_SG_WS_ADMIN_LOG_C
(	@pGameNo	int
,	@pAdminNo	int
,	@pMenuNo	int
,	@pHttpGet	nvarchar(max)
,	@pHttpPost	nvarchar(max)
,	@pReferer	nvarchar(max)
,	@pHostIp	varchar(15)
,	@oReturnNo	int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT001_SG_WS_MANGR_LOG
		(	cWorkDate
		,	cGameNo
		,	cAdminNo
		,	cMenuNo
		,	cHttpGet
		,	cHttpPost
		,	cReferer
		,	cHostIp
		,	cCreateTime
		)
	values
		(	convert(char(8),@vGetDate,112)
		,	@pGameNo
		,	@pAdminNo
		,	@pMenuNo
		,	nullif(@pHttpGet,'')
		,	nullif(@pHttpPost,'')
		,	nullif(@pReferer,'')
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
exec dbo.KWP00105_SG_WS_ADMIN_LOG_C
 @pGameNo = 20150001
,@pAdminNo = 100000001
,@pMenuNo = 1009002
,@pHttpGet = 'pLargePart=0&pMainFlag=False&pGameNo=20150001&pBoardNo=1000007&pBoardType=1&pPageNo=2&pIsNext=0&pJumpSize=1&pRowCnt=76&pLastNo=4016&pLastVo=0&pLimitDate=2015-05-04&pFilterKey=3&pListCnt=20&pDeleted=false&pNotice=false'
,@pHttpPost = 'drpLargePart=0&txtGameNo=20150001&txtMenuNo=1000007&txtWriteNo=3992&txtIsNew=1&txtMenuType=1&txtRows=13&txtLimitDate=2015-05-04&drpFilterKey=3&drpCategory=1&drpPageSize=20&drpMenuList=1000013'
,@pReferer = 'http://www.adminsite.dev/board/manage.aspx?pLargePart=0&pMainFlag=False&pGameNo=20150001&pBoardNo=1000007&pBoardType=1&pPageNo=2&pIsNext=0&pJumpSize=1&pRowCnt=76&pLastNo=4016&pLastVo=0&pLimitDate=2015-05-04&pFilterKey=3&pFilterText=&pListCnt=20&pDeleted=false&pNotice=false'
,@pHostIp = '127.0.0.1'
,@oReturnNo = @sp output

print @sp
*/
go

grant execute on dbo.KWP00105_SG_WS_ADMIN_LOG_C to [opwebuser]
go

