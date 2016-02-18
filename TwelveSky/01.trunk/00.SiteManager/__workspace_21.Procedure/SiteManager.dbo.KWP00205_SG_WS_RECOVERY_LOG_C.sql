use SiteManager
go
if object_id('dbo.KWP00205_SG_WS_RECOVERY_LOG_C') is null
	exec ('create procedure dbo.KWP00205_SG_WS_RECOVERY_LOG_C as select 1')
--	drop procedure dbo.KWP00205_SG_WS_RECOVERY_LOG_C
go
/******************************************************************************
	name		: dbo.KWP00205_SG_WS_RECOVERY_LOG_C
	description	: 영웅, 아이템, 플레이어 복구
	reference	:
	result		: @oReturnNo
					 0	: Success
					-1	: initialize error
					-2	: Insert error

		@pAction
			10 : 영웅 삭제
			11 : 영웅 복구
			20 : 아이템 삭제
			21 : 아이템 복구
			22 : 착용 아이템 복구
			30 : 플레이어 삭제
			31 : 플레이어 복구

	Ver		Date		Author			Description
	------	----------	--------------	------------------------------------
	1.0		2013-04-15	Hoon-Sik,Jin	1.CREATE
******************************************************************************/
alter procedure dbo.KWP00205_SG_WS_RECOVERY_LOG_C
(	@pServerNo		int
,	@pPlayerNo		bigint
,	@pNickName		nvarchar(16)
,	@pPublisher		bigint
,	@pAction		smallint
,	@pCreateNo		tinyint
,	@pDeleteNo		tinyint
,	@pObjectNo		bigint
,	@pObjectKey		smallint
,	@pAdminNo		int
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	declare	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	insert into dbo.KWT002_SG_WS_RECOVERY_LOG
		(	cWorkDate
		,	cServerNo
		,	cPlayerNo
		,	cNickName
		,	cPublisher
		,	cAction
		,	cCreateNo
		,	cDeleteNo
		,	cObjectNo
		,	cObjectKey
		,	cTryCnt
		,	cAdminNo
		,	cHostIp
		,	cCreateTime
		)
	values
		(	convert(char(8),@vGetDate,112)
		,	@pServerNo
		,	@pPlayerNo
		,	@pNickName
		,	@pPublisher
		,	@pAction
		,	@pCreateNo
		,	@pDeleteNo
		,	@pObjectNo
		,	@pObjectKey
		,	1
		,	@pAdminNo
		,	@pHostIp
		,	@vGetDate
		)

	if @@error != 0
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
exec dbo.KWP00205_SG_WS_RECOVERY_LOG_C
 @pServerNo = 1
,@pPlayerNo = 222274
,@pNickName = '이유반'
,@pPublisher = 88151987532876768
,@pAction = 11
,@pCreateNo = 10
,@pDeleteNo = 0
,@pObjectNo = 27363964
,@pAdminNo = 100000005
,@pHostIp = '222.117.240.137'
,@oReturnNo = @sp output

print @sp

dbo.KWT002_SG_WS_RECOVERY_LOG
where	cPlayerNo = 337164
*/
go

grant execute on dbo.KWP00205_SG_WS_RECOVERY_LOG_C to [opwebuser]

