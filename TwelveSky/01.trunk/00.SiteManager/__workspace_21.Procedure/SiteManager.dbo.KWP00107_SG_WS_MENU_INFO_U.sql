use SiteManager
go
if object_id('dbo.KWP00107_SG_WS_MENU_INFO_U') is null
	exec ('create procedure dbo.KWP00107_SG_WS_MENU_INFO_U as select 1')
--	drop procedure dbo.KWP00107_SG_WS_MENU_INFO_U
go
/******************************************************************************
	Name		: dbo.KWP00107_SG_WS_MENU_INFO_U
	Description	: 기존 메뉴 변경
	Reference	:
	return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2013-05-02	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00107_SG_WS_MENU_INFO_U
(	@pMenuNo		int
,	@pMenuName		nvarchar(10)
,	@pExecUrl		varchar(120)
,	@pGroupOld		int
,	@pGroupNew		int
,	@pIsUsed		bit
,	@pSeqNoOld		tinyint
,	@pSeqNoNew		tinyint
,	@pNoteText		nvarchar(50)
,	@pHostIp		varchar(15)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vMenuNo int
		,	@vGetDate datetime = getdate()
	set @oReturnNo = -1

	-- 그룹 이동
	if @pGroupOld != @pGroupNew
	begin
		select	@vMenuNo	= isnull(max(cMenuNo),(1000+right(@pGroupNew,1))*100000) + 1
		from	dbo.KWT001_SG_WS_MENU_LIST
		where	cMenuGroup	= @pGroupNew

		begin tran
			-- 기존 메뉴 삭제
			delete
			from	dbo.KWT001_SG_WS_MENU_LIST
			where	cMenuNo = @pMenuNo

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -2
				return
			end


			-- 새로운 메뉴로 등록
			insert into dbo.KWT001_SG_WS_MENU_LIST
				(	cMenuNo
				,	cMenuName
				,	cMenuGroup
				,	cExecUrl
				,	cNoteText
				,	cIsUsed
				,	cOrderBy
				,	cHostIp
				,	cCreateTime
				)
			select	@vMenuNo
				,	@pMenuName
				,	@pGroupNew
				,	@pExecUrl
				,	@pNoteText
				,	@pIsUsed
				,	isnull(max(cOrderBy),0) + 1
				,	@pHostIp
				,	@vGetDate
			from	dbo.KWT001_SG_WS_MENU_LIST
			where	cMenuGroup	= @pGroupNew

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -3
				return
			end


			-- 기존 권한 관계 끊기
			delete
			from	dbo.KWT001_SG_WS_MENU_GROUP_ROLE
			where	cMenuNo = @pMenuNo

			if @@rowcount = 0
			begin
				if @@trancount > 0 rollback tran
				set @oReturnNo = -4
				return
			end
		commit tran


		set @oReturnNo = 0
		return
	end



	-- 내용 변경
	update	a
	set		cMenuName	= @pMenuName
		,	cExecUrl	= @pExecUrl
		,	cNoteText	= @pNoteText
		,	cIsUsed		= @pIsUsed
		,	cHostIp		= @pHostIp
		,	cModifyTime	= @vGetDate
	from	dbo.KWT001_SG_WS_MENU_LIST as a
	where	cMenuNo		= @pMenuNo

	if @@rowcount = 0
	begin
		set @oReturnNo = -5
		return
	end

	-- 순서 변경이 없는 경우 여기서 중단
	if @pSeqNoOld = @pSeqNoNew
	begin
		set @oReturnNo = 0
		return
	end



	begin tran
		-- 변경 할 메뉴 255로 임시 처리
		update	a
		set		cOrderBy	= 255
		from	dbo.KWT001_SG_WS_MENU_LIST as a
		where	cMenuGroup	= @pGroupOld
			and	cMenuNo		= @pMenuNo

		if @@rowcount = 0
		begin
			set @oReturnNo = -6
			return
		end


		if @pSeqNoNew > @pSeqNoOld
		begin
			update	a
			set		cOrderBy	-= 1
			from	dbo.KWT001_SG_WS_MENU_LIST as a
			where	cMenuGroup	= @pGroupOld
				and	cOrderBy	between @pSeqNoOld and @pSeqNoNew

			if @@rowcount = 0
			begin
				set @oReturnNo = -7
				return
			end


			update	a
			set		cOrderBy	= @pSeqNoNew
			from	dbo.KWT001_SG_WS_MENU_LIST as a
			where	cMenuGroup	= @pGroupOld
				and	cMenuNo		= @pMenuNo

			if @@rowcount = 0
			begin
				set @oReturnNo = -8
				return
			end
		end
		-- 큰 수에서 작은 수로 변경되는 경우
		else if @pSeqNoNew < @pSeqNoOld
		begin
			update	a
			set		cOrderBy	+= 1
			from	dbo.KWT001_SG_WS_MENU_LIST as a
			where	cMenuGroup	= @pGroupOld
				and	cOrderBy	between @pSeqNoNew and @pSeqNoOld

			if @@rowcount = 0
			begin
				set @oReturnNo = -9
				return
			end


			update	a
			set		cOrderBy	= @pSeqNoNew
			from	dbo.KWT001_SG_WS_MENU_LIST as a
			where	cMenuGroup	= @pGroupOld
				and	cMenuNo		= @pMenuNo

			if @@rowcount = 0
			begin
				set @oReturnNo = -10
				return
			end
		end
	commit tran



	set @oReturnNo = 0
	set nocount off
end
/*
use SiteManager
declare
 @o1 varchar(20)
,@o2 varchar(120)
,@o3 int
,@o4 bit
,@o5 int
,@o6 varchar(100)
,@sp int
exec dbo.KWP00107_SG_WS_MENU_INFO_U
 @pMenuNo = 100100001
,@oMenuName = @o1 output
,@oMenuUrl = @o2 output
,@oMenuGroup = @o3 output
,@oIsUsed = @o4 output
,@oOrderBy = @o5 output
,@oNoteText = @o6 output
,@oReturnNo = @sp output

print @o1
print @o2
print @o3
print @o4
print @o5
print @o6
print @sp
*/
go

grant execute on dbo.KWP00107_SG_WS_MENU_INFO_U to [opwebuser]
go

