use SiteManager
go
if object_id('dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R') is null
	exec ('create procedure dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R as select 1')
--	drop procedure dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R
go
/******************************************************************************
	name		: dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R
	description	: 영웅, 아이템, 플레이어 복구 내역
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error

		cAction
			20010 : 영웅 삭제
			20009 : 영웅 복구
			20019 : 아이템 삭제
			20018 : 아이템 복구
			20018 : 착용 아이템 복구
			20000 : 플레이어 삭제
			20052 : 플레이어 복구

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-04-23	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R
(	@pPublisher		bigint
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set @oReturnNo = -1

	select	cServerNo
		,	cPlayerNo
		,	cNickName
		,	cAction
		,	cCreateNo
		,	cDeleteNo
		,	cObjectNo
		,	cObjectKey
		,	cHostIp
		,	cCreateTime as cCreateTimes
	from	dbo.KWT002_SG_WS_RECOVERY_LOG with(nolock)
	where	cPublisher	= @pPublisher


	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare @sp int
exec dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R
 @pPublisher = 88205865609415265
,@oReturnNo = @sp output

print @sp

select cPublisher,count(*) as rowcnt
from dbo.KWT002_SG_WS_RECOVERY_LOG
group by cPublisher
having count(*) > 1
order by rowcnt desc

dbo.KWT002_SG_WS_RECOVERY_LOG
where	cPublisher	= 88300038752231648
*/
go

grant execute on dbo.KWP00202_SG_WS_RECOVERY_LOG_LIST_R to [opwebuser]

