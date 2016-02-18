use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_GRP_SITE_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_GRP_SITE_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_GRP_SITE_INFO_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_GRP_SITE_INFO_U
	Description	: 관리자 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					 1	: 파라미터 값 오류
					-1	: initialize error
					-2	: UPDATE error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_GRP_SITE_INFO_U
(	@pSiteGroup		int
,	@pSiteName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pIsUsed		bit
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if @pSiteName = '' or @pNoteText = ''
	begin
		set @oReturnNo = 1
		return
	end


	update	a
	set		cSiteName	= @pSiteName
		,	cNoteText	= @pNoteText
		,	cIsUsed		= @pIsUsed
		,	cHostIp		= @pHostIp
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_SITE_GROUP_MST as a
	where	cSiteGroup	= @pSiteGroup

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
declare
 @o1 varchar(100)
,@o2 varchar(150)
,@o3 int
,@sp int
exec dbo.KWP00107_SG_WS_GRP_SITE_INFO_U
 @pSiteGroup = 10001
,@pSiteName = ''
,@pNoteText = ''
,@pIsUsed = 1
,@pHostIp = ''
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_GRP_SITE_INFO_U to [opwebuser]
go

