use TwelveskyWeb
go
if object_id('dbo.uspGetArticleInfo') is null
	exec ('create procedure dbo.uspGetArticleInfo as select 1')
--	drop procedure dbo.uspGetArticleInfo
go
/******************************************************************************
	Name		: dbo.uspGetArticleInfo
	Description	: 게시물 권한 체크
	Reference	:
	Return		: @oReturnNo
					0	: Success
					1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2016-01-30	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArticleInfo
(	@pMenuNo	int
,	@pWriteNo	bigint
,	@pAccountNo	bigint
,	@oReturnNo	int		output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted
	set @oReturnNo = -99

	if not exists (
		select	1
		from	dbo.tArticleInfo
		where	cMenuNo		= @pMenuNo
			and	cWriteNo	= @pWriteNo
			and	cAccountNo	= @pAccountNo
	)
	begin
		set @oReturnNo = -1
		return -1
	end


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare
 @sp int
,@rt int
exec dbo.uspGetArticleInfo
 @pMenuNo = 1000001
,@pWriteNo = 1
,@pAccountNo = 20
,@oReturnNo = @rt out

print @sp
print @rt
*/
go

grant execute on dbo.uspGetArticleInfo to [sawebuser]
go

