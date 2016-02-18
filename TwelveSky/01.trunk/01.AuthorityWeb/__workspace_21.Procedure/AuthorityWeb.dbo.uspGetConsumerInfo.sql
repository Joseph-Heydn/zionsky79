use AuthorityWeb
go
if object_id('dbo.uspGetConsumerInfo') is null
	exec ('create procedure dbo.uspGetConsumerInfo as select 1')
--	drop procedure dbo.uspGetConsumerInfo
go
/******************************************************************************
	Name		: dbo.uspGetConsumerInfo
	Description	: api - 컨슈머 정보
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetConsumerInfo
(	@pConsumerKey	char(10)
,	@oGameNo		int				output
,	@oSecret		char(15)		output
,	@oCallBack		varchar(100)	output
,	@oReturnNo		int				output

) as
begin
	set nocount on
	set transaction isolation level read uncommitted

	select	@oGameNo	= 0
		,	@oCallBack	= ''
		,	@oSecret	= 0
		,	@oReturnNo	= -1

	select	@oGameNo		= cGameNo
		,	@oSecret		= cSecret
		,	@oCallBack		= isnull(cCallBackURL,'')
	from	dbo.tConsumerInfo
	where	cConsumerKey	= @pConsumerKey
		and cStatus			= 1

	if @@rowcount = 0
	begin
		set @oReturnNo = 1
		return 1
	end


	set @oReturnNo = 0
	return 0
end
go

grant execute on dbo.uspGetConsumerInfo to [sawebuser]
go

