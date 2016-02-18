use SiteManager
go
if object_id('dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C') is null
	exec ('create procedure dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C as select 1')
--	drop procedure dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C
go
/******************************************************************************
	name		: KWP00105_SG_WS_GRP_AUTH_INFO_C
	description	: 권한 그룹 생성하기
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: duplicate group name
					-3	: INSERT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-08	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C
(	@pSiteGroup		smallint
,	@pCommName		nvarchar(20)
,	@pNoteText		nvarchar(50)
,	@pHostIp		varchar(15)
,	@pIsUsed		bit
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	if exists (
		select	1
		from	dbo.KWT001_SG_WS_COMM_GROUP_MST
		where	cSiteGroup	= @pSiteGroup
			and	cCommName	= @pCommName
	)
	begin
		set @oReturnNo = -2
		return
	end


	-- 그룹 기본정보
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
		,	max(cCommGroup) + 1
		,	@pCommName
		,	max(cOrderBy) + 1
		,	@pNoteText
		,	@pIsUsed
		,	@pHostIp
		,	@vGetDate
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST
	where	cSiteGroup = @pSiteGroup

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
exec dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C
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

grant execute on dbo.KWP00105_SG_WS_GRP_AUTH_INFO_C to [opwebuser]
go

