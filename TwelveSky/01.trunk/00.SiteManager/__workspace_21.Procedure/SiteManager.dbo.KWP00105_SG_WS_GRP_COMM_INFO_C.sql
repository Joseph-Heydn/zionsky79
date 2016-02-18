use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_COMM_INFO_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_COMM_INFO_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_COMM_INFO_C
go
/******************************************************************************
	Name		: dbo.KWP00105_SG_WS_GRP_COMM_INFO_C
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
alter procedure dbo.KWP00105_SG_WS_GRP_COMM_INFO_C
(	@pSiteGroup		int
,	@pCommName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pIsUsed		bit
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vMenuGroup int
		,	@vExecUrl	nvarchar(20)
		,	@vGetDate	datetime = getdate()
	set @oReturnNo = -1

	if @pCommName = '' or @pNoteText = ''
	begin
		set @oReturnNo = 1
		return
	end

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST
		where	cSiteGroup	= @pSiteGroup
			and	cCommName	= @pCommName
	)
	begin
		set @oReturnNo = 2
		return
	end


	insert into dbo.KWT001_SG_WS_COMM_GROUP_MST
		(	cSiteGroup
		,	cCommGroup
		,	cCommName
		,	cOrderBy
		,	cNoteText
		,	cIsUsed
		,	cHostIp
		,	cCreateTime
		)
	select	@pSiteGroup
		,	isnull(max(cCommGroup),(@pSiteGroup*1000)) + 1
		,	@pCommName
		,	isnull(max(cOrderBy),0) + 1
		,	@pNoteText
		,	@pIsUsed
		,	@pHostIp
		,	@vGetDate
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup = @pSiteGroup

	if @@rowcount = 0
	begin
		set @oReturnNo = -2
		return
	end


	select	top 1
			@vMenuGroup	= cCommGroup
		,	@vExecUrl	= '/App/'+ rtrim(cCommGroup)
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup	= @pSiteGroup
		and	cCommName	= @pCommName

	if not exists (
		select	top 1 1
		from	dbo.KWT001_SG_WS_MENU_LIST
		where	cMenuGroup = @vMenuGroup
			and	cMenuNo		= right(@pSiteGroup,5) * 1000
	)
	begin
		exec dbo.KWP00105_SG_WS_MENU_INFO_C
				@pMenuName		= @pCommName
			,	@pExecUrl		= @vExecUrl
			,	@pMenuGroup		= @vMenuGroup
			,	@pIsUsed		= 1
			,	@pIsView		= 1
			,	@pNoteText		= ''
			,	@pHostIp		= null
			,	@oReturnNo		= @oReturnNo output

		if @@error != 0 or @oReturnNo != 0
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
exec dbo.KWP00105_SG_WS_GRP_COMM_INFO_C
 @pCommGroup = 100100001
,@pCommName = ''
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

grant execute on dbo.KWP00105_SG_WS_GRP_COMM_INFO_C to [opwebuser]
go

