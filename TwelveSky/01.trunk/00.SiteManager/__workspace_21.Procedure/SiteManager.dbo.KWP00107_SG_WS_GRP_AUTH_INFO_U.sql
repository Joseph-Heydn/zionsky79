use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U
go
/******************************************************************************
	name		: KWP00107_SG_WS_GRP_AUTH_INFO_U
	description	: 권한 그룹내용 변경하기
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: duplicate group name
					-3	: UPDATE error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U
(	@pSiteGroup		smallint
,	@pCommGroup		int
,	@pCommName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pHostIp		varchar(15)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
		where	cSiteGroup	= @pSiteGroup
			and	cCommGroup	!= @pCommGroup
			and	cCommName	= @pCommName
	)
	begin
		set @oReturnNo = -2
		return
	end


	-- 그룹 기본정보
	update	a
	set		cCommName	= @pCommName
		,	cNoteText	= @pNoteText
		,	cHostIp		= @pHostIp
		,	cIsUsed		= @pIsUsed
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
	where	cCommGroup	= @pCommGroup
		and	cSiteGroup	= @pSiteGroup

	if @@rowcount != 1
	begin
		set @oReturnNo = -3
		return
	end


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 int
,@o2 varchar(100)
,@o3 bit
,@o4 varchar(150)
,@sp int
exec dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U
 @pCommGroup = 100200004
,@o_cAuthGroup = @o1 output
,@o_cAuthName = @o2 output
,@oIsUsed = @o3 output
,@oNoteText = @o4 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_GRP_AUTH_INFO_U to [opwebuser]
go

