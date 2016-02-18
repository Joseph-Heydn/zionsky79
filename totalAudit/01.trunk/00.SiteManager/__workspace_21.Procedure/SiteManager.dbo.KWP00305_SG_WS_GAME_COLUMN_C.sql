use SiteManager
go
if object_id('dbo.KWP00305_SG_WS_GAME_COLUMN_C') is null
	exec ('create procedure dbo.KWP00305_SG_WS_GAME_COLUMN_C as select 1')
--	drop procedure dbo.KWP00305_SG_WS_GAME_COLUMN_C
go
/******************************************************************************
	Name		: dbo.KWP00305_SG_WS_GAME_COLUMN_C
	Description	: 테이블 리스트
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-07-24	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.KWP00305_SG_WS_GAME_COLUMN_C
(	@pTableNo		int
,	@pColumns		varchar(50)
,	@pComment		nvarchar(1000)
,	@pVitalCols		varchar(30)
,	@pUsingCols		varchar(30)
,	@oReturnNo		int		output

) as
begin
	set nocount on
	set xact_abort on
	set transaction isolation level read uncommitted

	declare	@vGetDate	datetime = getdate()
		,	@vErrorMsg	nvarchar(max) = ''
	set @oReturnNo = -1

	create table #tmpColumnInfo
	(	cColumnNo	int				not null
	,	cColumnText	nvarchar(16)	not null
	,	cVitals		bit				not null
	,	cIsUsed		bit				not null
	)


	begin try
		begin tran
			set @oReturnNo = 2
			-- @pTableNo 있으면 삭제
			delete
			from	dbo.KWT003_SG_WS_GAME_COLUMN
			where	cTableNo = @pTableNo


			set @oReturnNo = 3
			insert into #tmpColumnInfo
				(	cColumnNo
				,	cColumnText
				,	cVitals
				,	cIsUsed
				)
			exec dbo.uspArray2Table
					@pString0 = @pColumns
				,	@pString1 = @pComment
				,	@pString2 = @pVitalCols
				,	@pString3 = @pUsingCols

			if @@error != 0 or @@rowcount = 0
			begin
				select	@oReturnNo = -3
					,	@vErrorMsg = '@pTableNo = '+ rtrim(@pTableNo)
					,	@vErrorMsg += ', @pColumns = '+ rtrim(@pColumns)
					,	@vErrorMsg += ', @pComment = '+ rtrim(@pComment)
					,	@vErrorMsg += ', @pVitalCols = '+ rtrim(@pVitalCols)
					,	@vErrorMsg += ', @pUsingCols = '+ rtrim(@pUsingCols)
				raiserror('error #%d : %s', 16, 1, @oReturnNo, @vErrorMsg);
			end


			set @oReturnNo = 4
			insert into dbo.KWT003_SG_WS_GAME_COLUMN
				(	cTableNo
				,	cColumnNo
				,	cColumnText
				,	cVitals
				,	cIsUsed
				,	cCreateTime
				)
			select	@pTableNo
				,	cColumnNo
				,	nullif(cColumnText,'')
				,	cVitals
				,	cIsUsed
				,	@vGetDate
			from	#tmpColumnInfo
		commit tran
	end try

	begin catch
		if @@trancount > 0 rollback tran
		drop table #tmpColumnInfo

		exec dbo.uspSetNewErrorLog
				@pPrintMsg	= 0
			,	@oErrorNo	= @oReturnNo output

		return @oReturnNo
	end catch


	drop table #tmpColumnInfo
	set @oReturnNo = 0

	return 0
end
/*
set statistics io on
use SiteManager
declare @rt int
exec dbo.KWP00305_SG_WS_GAME_COLUMN_C
 @pTableName = ''
,@oReturnNo = @rt out

print @rt
*/
go

grant execute on dbo.KWP00305_SG_WS_GAME_COLUMN_C to [opwebuser]
go

