use TwelveskyWeb
go
if object_id('dbo.uspGetNewFileNo') is null
	exec ('create procedure dbo.uspGetNewFileNo as select 1')
--	drop procedure dbo.uspGetNewFileNo
go
/******************************************************************************
	Name		: dbo.uspGetNewFileNo
	Description	: 파일 번호 받기
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-17	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetNewFileNo
(	@pFileCnt	int
,	@oFileNo	varchar(350)	output
,	@oReturnNo	int				output

) with execute as 'dbo' as
begin
	set nocount on
	set transaction isolation level read uncommitted

	declare	@vStartVal	sql_variant
		,	@vLimitVal	sql_variant
		,	@vStartNo	bigint
		,	@vLimitNo	bigint
	select	@oFileNo	= ''
		,	@oReturnNo	= -1

	if @pFileCnt = 1
	begin
		set @oFileNo = next value for dbo.sFileNo
		set @oFileNo += '|'
	end
	else
	begin
		exec sys.sp_sequence_get_range
				@sequence_name		= N'sFileNo'
			,	@range_size			= @pFileCnt
			,	@range_first_value	= @vStartVal output
			,	@range_last_value	= @vLimitVal output

		select	@vStartNo = convert(bigint,@vStartVal)
			,	@vLimitNo = convert(bigint,@vLimitVal)

		select	top (@vLimitNo-@vStartNo+1)
				@oFileNo += rtrim((@vStartNo-1) + row_number() over(order by (select 1))) +'|'
		from	dbo.tFileInfo
	end


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use TwelveskyWeb
declare
 @o1 varchar(2000)
,@sp int
,@rt int
exec @sp = dbo.uspGetNewFileNo
 @pFileCnt = 3
,@oFileNo = @o1 out
,@oReturnNo = @rt out

print @o1
print @sp
print @rt


alter sequence dbo.sFileNo restart with 7000000001
select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sFileNo'
*/
go

grant execute on dbo.uspGetNewFileNo to sawebuser
go

