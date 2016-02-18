use TwelveskyWeb
go
if object_id('dbo.uspSetReportWrite') is null
	exec ('create procedure dbo.uspSetReportWrite as select 1')
--	drop procedure dbo.uspSetReportWrite
go
/******************************************************************************
	Name		: dbo.uspSetReportWrite
	Description	: �Խù� ��õ/�Ű�
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-02-25	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspSetReportWrite
(	@pMenuNo		int
,	@pWriteNo		bigint
,	@pPublisher		tinyint		-- 1:my, 2:ph, 3:th, 4:vn
,	@pCommtNo		bigint
,	@pAccountNo		bigint			-- ��õ/�Ű� �Ϸ��� ����
,	@pWriter		nvarchar(16)	-- ��õ/�Ű� �Ϸ��� ����
,	@pReportType	tinyint			-- 01:����õ, 02:�Ű�, 03:�ݴ�, 11:�����õ, 12:�Ű�, 13:�ݴ�
,	@oRecmdCnt		int		output	-- ��õ
,	@oAgnstCnt		int		output	-- �ݴ�
,	@oRepotCnt		int		output	-- �Ű�
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vAccountNo	bigint
		,	@vTypeA		tinyint
		,	@vTypeB		tinyint
		,	@vWriter	nvarchar(20)
	select	@oRecmdCnt = 0
		,	@oAgnstCnt = 0
		,	@oRepotCnt = 0
		,	@oReturnNo = 1

	if @pMenuNo = 0 or @pAccountNo = 0 or @pWriteNo = 0
	begin
		set @oReturnNo = -1
		return -1
	end


	-- �Խù�
	if @pReportType between 1 and 3
	begin
		select	@vAccountNo	= cAccountNo
			,	@vWriter	= cWriter
		from	dbo.tArticleInfo
		where	cWriteNo	= @pWriteNo
			and	cPublisher	= @pPublisher
			and	cDrop		= 0

		-- �������� �ʴ� �Խù�
		if @@rowcount = 0
		begin
			set @oReturnNo = 2
			return 2
		end

		-- ���α� ��õ/�Ű� �ӵ�
		if @vAccountNo = @pAccountNo
		begin
			set @oReturnNo = 3
			return 3
		end
	end


	-- ���
	if @pReportType between 11 and 13
	begin
		select	@vAccountNo	= cAccountNo
			,	@vWriter	= cWriter
		from	dbo.tCommentInfo
		where	cWriteNo	= @pWriteNo
			and	cCommtNo	= @pCommtNo
			and	cDrop		= 0

		-- �������� �ʴ� �Խù�
		if @@rowcount = 0
		begin
			set @oReturnNo = 4
			return 4
		end

		-- ���α� ��õ/�Ű� �ӵ�
		if @vAccountNo = @pAccountNo
		begin
			set @oReturnNo = 5
			return 5
		end
	end


	-- �Խù� �ߺ� ��õ/�ݴ� �ӵ�
	select	@vTypeA			= case when cType in (01,03) then 1 else @vTypeA end	-- �Խù�
		,	@vTypeB			= case when cType in (11,13) then 1 else @vTypeB end	-- ���
	from	dbo.tReportInfo
	where	cWriteNo		= @pWriteNo
		and	cCommtNo		= @pCommtNo
		and	cRpAccountNo	= @pAccountNo
		and	cType			in (1,3,11,13)

	if @pReportType in (01,03) and @vTypeA = 1
	begin
		set @oReturnNo = 6
		return 6
	end

	if @pReportType in (11,13) and @vTypeB = 1
	begin
		set @oReturnNo = 6
		return 6
	end


	-- �ߺ� �Ű� �ӵ�
	select	@vTypeA			= case cType when 02 then 1 else @vTypeA end
		,	@vTypeB			= case cType when 12 then 1 else @vTypeB end
	from	dbo.tReportInfo
	where	cWriteNo		= @pWriteNo
		and	cCommtNo		= @pCommtNo
		and	cRpAccountNo	= @pAccountNo
		and	cType			in (2,12)

	if @pReportType = 02 and @vTypeA = 1
	begin
		set @oReturnNo = 7
		return 7
	end

	if @pReportType = 12 and @vTypeB = 1
	begin
		set @oReturnNo = 7
		return 7
	end


	begin try
		begin tran
			set @oReturnNo = 8
			-- ������ �Է�
			insert into dbo.tReportInfo
				(	cReportNo
				,	cMenuNo
				,	cWriteNo
				,	cCommtNo
				,	cTgAccountNo
				,	cTgNickName
				,	cRpAccountNo
				,	cRpNickName
				,	cType
				,	cCreateTime
				)
			values
				(	next value for dbo.sReportNo
				,	@pMenuNo
				,	@pWriteNo
				,	@pCommtNo
				,	@vAccountNo
				,	@vWriter
				,	@pAccountNo
				,	@pWriter
				,	@pReportType
				,	getdate()
				)


			set @oReturnNo = 9
			-- �� �Խù��� count ����
			if @pReportType between 1 and 3
			begin
				update	a
				set		@oRecmdCnt	= cRecmdCnt = isnull(cRecmdCnt,0) + case @pReportType when 01 then 1 else 0 end
					,	@oAgnstCnt	= cAgnstCnt = isnull(cAgnstCnt,0) + case @pReportType when 03 then 1 else 0 end
					,	@oRepotCnt	= cRepotCnt = isnull(cRepotCnt,0) + case @pReportType when 02 then 1 else 0 end
				from	dbo.tArticleInfo as a
				where	cMenuNo		= @pMenuNo
					and	cWriteNo	= @pWriteNo
			end

			else if @pReportType between 11 and 13
			begin
				update	a
				set		@oRecmdCnt	= cRecmdCnt	= isnull(cRecmdCnt,0) + case @pReportType when 11 then 1 else 0 end
					,	@oAgnstCnt	= cAgnstCnt = isnull(cAgnstCnt,0) + case @pReportType when 13 then 1 else 0 end
					,	@oRepotCnt	= cRepotCnt	= isnull(cRepotCnt,0) + case @pReportType when 12 then 1 else 0 end
				from	dbo.tCommentInfo as a
				where	cWriteNo	= @pWriteNo
					and	cCommtNo	= @pCommtNo
			end
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare
 @sp int
,@o1 int
,@o2 int
,@o3 int
,@rt int
exec @sp = dbo.uspSetReportWrite
 @pMenuNo = 1000007
,@pWriteNo = 6256
,@pPublisher = 1
,@pCommtNo = 0
,@pAccountNo = 1000001
,@pWriter = 'efghg7'
,@pReportType = 3
,@oRecmdCnt = @o1 out
,@oAgnstCnt = @o2 out
,@oRepotCnt = @o3 out
,@oReturnNo = @rt out

print @o1
print @o2
print @o3
print @sp
print @rt
*/
go

grant execute on dbo.uspSetReportWrite to [sawebuser]
go

