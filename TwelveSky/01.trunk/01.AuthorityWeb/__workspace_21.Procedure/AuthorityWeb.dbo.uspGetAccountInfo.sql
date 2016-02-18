use AuthorityWeb
go
if object_id('dbo.uspGetAccountInfo') is null
	exec ('create procedure dbo.uspGetAccountInfo as select 1')
--	drop procedure dbo.uspGetAccountInfo
go
/******************************************************************************
	Name		: dbo.uspGetAccountInfo
	Description	: 유저 상세 정보
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetAccountInfo
(	@pAccountNo		bigint
,	@oNickName		nvarchar(20)	output
,	@oExts			char(3)			output
,	@oBirthDay		smalldatetime	output
,	@oIsEmail		bit				output
,	@oIsPhoto		bit				output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oNickName	= ''
		,	@oBirthDay	= 0
		,	@oIsEmail	= 0
		,	@oIsPhoto	= 0
		,	@oReturnNo	= -1

	select	@oNickName	= cNickName
		,	@oExts		= isnull(cExts,'')
		,	@oBirthDay	= isnull(cBirthDay,0)
		,	@oIsEmail	= cIsEmail
		,	@oIsPhoto	= cIsPhoto
	from	dbo.tAccountInfo
	where	cAccountNo	= @pAccountNo


	set @oReturnNo = 0
	return 0
end
/*
set statistics io on
use AuthorityWeb
declare
 @o1 nvarchar(20)
,@o2 char(3)
,@o3 smalldatetime
,@o4 bit
,@o5 bit
,@rt int
,@sp int
exec @sp = dbo.uspGetAccountInfo
 @pAccountNo = 100019650
,@oNickName = @o1 out
,@oExts = @o2 out
,@oBirthDay = @o3 out
,@oIsEmail = @o4 out
,@oIsPhoto = @o5 out
,@oReturnNo = @rt out

print  '@oNickName	: '+ isnull(rtrim(@o1),'')
print  '@oExts		: '+ isnull(rtrim(@o2),'')
print  '@oBirthDay	: '+ isnull(convert(char(13),@o3,121),0)
print  '@oIsEmail	: '+ isnull(rtrim(@o4),0)
print  '@oIsPhoto	: '+ isnull(rtrim(@o5),0)
print  '@vReturnNo	: '+ rtrim(@rt)
print  '@oReturnNo	: '+ rtrim(@sp)
*/
go

grant execute on dbo.uspGetAccountInfo to [sawebuser]
go

