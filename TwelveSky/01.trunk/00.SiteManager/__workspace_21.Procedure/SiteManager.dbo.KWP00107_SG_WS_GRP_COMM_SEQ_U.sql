use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U
go
/******************************************************************************
	name		: KWP00107_SG_WS_GRP_COMM_SEQ_U
	description	: 사이트 코드에 대한 그룹코드 순서 변경
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: SELECT error

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-03-13	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U
(	@pSiteGroup		smallint
,	@pCommGroup		int
,	@pSeqNoOld		tinyint
,	@pSeqNoNew		tinyint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	begin tran
		-- 작은 수에서 큰 수로 변경되는 경우
		if @pSeqNoNew > @pSeqNoOld
		begin
			update	a
			set		cOrderBy	-= 1
			from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			where	cSiteGroup	= @pSiteGroup
				and	cOrderBy	between @pSeqNoOld and @pSeqNoNew

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -3
				return
			end


			update	a
			set		cOrderBy	= @pSeqNoNew
			from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			where	cSiteGroup	= @pSiteGroup
				and	cCommGroup	= @pCommGroup

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -2
				return
			end
		end
		-- 큰 수에서 작은 수로 변경되는 경우
		else if @pSeqNoNew < @pSeqNoOld
		begin
			update	a
			set		cOrderBy	+= 1
			from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			where	cSiteGroup	= @pSiteGroup
				and	cOrderBy	between @pSeqNoNew and @pSeqNoOld

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -3
				return
			end


			update	a
			set		cOrderBy	= @pSeqNoNew
			from	dbo.KWT001_SG_WS_COMM_GROUP_MST as a
			where	cSiteGroup	= @pSiteGroup
				and	cCommGroup	= @pCommGroup

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -2
				return
			end
		end
	commit tran


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @SP int
exec dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U
 @pSiteGroup = 10003
,@pCommGroup = 100300003
,@pSeqNoOld = 7
,@pSeqNoNew = 3
,@oReturnNo = @SP output

print @SP

select	*
from	dbo.KWT001_SG_WS_COMM_GROUP_MST with(nolock)
where	cSiteGroup = 10003
order by cOrderBy
*/
go

grant execute on dbo.KWP00107_SG_WS_GRP_COMM_SEQ_U to [opwebuser]
go

