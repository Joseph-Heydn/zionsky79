use SiteManager
go
if object_id('dbo.KWP00104_SG_WS_GRP_COMM_INFO_R') is null
	exec ('create procedure dbo.KWP00104_SG_WS_GRP_COMM_INFO_R as select 1')
--	drop procedure dbo.KWP00104_SG_WS_GRP_COMM_INFO_R
go
/******************************************************************************
	Name		: dbo.KWP00104_SG_WS_GRP_COMM_INFO_R
	Description	: 공통 그룹 목록
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00104_SG_WS_GRP_COMM_INFO_R
(	@pCommGroup		int
,	@oCommName		nvarchar(20)	output
,	@oNoteText		nvarchar(50)	output
,	@oIsUsed		bit				output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	@oCommName	= cCommName
		,	@oNoteText	= cNoteText
		,	@oIsUsed	= cIsUsed
	from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
	where	cCommGroup	= @pCommGroup


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
exec dbo.KWP00104_SG_WS_GRP_COMM_INFO_R
 @pCommGroup = 100100001
,@oCommName = @o1 output
,@oNoteText = @o2 output
,@oIsUsed = @o3 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @sp
*/
go

grant execute on dbo.KWP00104_SG_WS_GRP_COMM_INFO_R to [opwebuser]
go

