use SiteManager
go
if object_id('dbo.uspGetArray2Table') is null
	exec ('create procedure dbo.uspGetArray2Table as select 1')
--	drop procedure dbo.uspGetArray2Table
go
/******************************************************************************
	Name		: dbo.uspGetArray2Table
	Description	: Array형 문자열을 Table 형태로 변환
	Reference	:
	Return		: @oReturnNo
					 0	: Success
					-1	: initialize error

	Ver		Date		Author			Description
	------	----------	--------------	---------------------------------------
	1.0		2015-04-01	Hoon-Sik,Jin	1.CREATE
 ******************************************************************************/
alter procedure dbo.uspGetArray2Table
(	@pString0	nvarchar(2000)
,	@pString1	nvarchar(2000) = ''
,	@pString2	nvarchar(2000) = ''
,	@pString3	nvarchar(2000) = ''
,	@pString4	nvarchar(2000) = ''
,	@pString5	nvarchar(2000) = ''
,	@pString6	nvarchar(2000) = ''
,	@pString7	nvarchar(2000) = ''
,	@pString8	nvarchar(2000) = ''
,	@pString9	nvarchar(2000) = ''

) as
begin
	set nocount on
	set xact_abort on
	set lock_timeout 5000
	set transaction isolation level read uncommitted

	declare	@vTmp1 varchar(100) = ''
		,	@vTmp2 varchar(100) = ''
		,	@vSeqNo int
		,	@vStart int = 1
		,	@vLimit int = len(@pString0) - len(replace(@pString0,'|',''))
		,	@vStr0 nvarchar(90)
		,	@vStr1 nvarchar(90)
		,	@vStr2 nvarchar(90)
		,	@vStr3 nvarchar(90)
		,	@vStr4 nvarchar(90)
		,	@vStr5 nvarchar(90)
		,	@vStr6 nvarchar(90)
		,	@vStr7 nvarchar(90)
		,	@vStr8 nvarchar(90)
		,	@vStr9 nvarchar(90)
		,	@vCols varchar(100) = 'c0,c1,c2,c3,c4,c5,c6,c7,c8,c9'
		,	@vSQL nvarchar(max) = ''

	if @pString1 = '' set @vSeqNo = 1
	else if @pString2 = '' set @vSeqNo = 2
	else if @pString3 = '' set @vSeqNo = 3
	else if @pString4 = '' set @vSeqNo = 4
	else if @pString5 = '' set @vSeqNo = 5
	else if @pString6 = '' set @vSeqNo = 6
	else if @pString7 = '' set @vSeqNo = 7
	else if @pString8 = '' set @vSeqNo = 8
	else if @pString9 = '' set @vSeqNo = 9

	select	@pString0 = case @pString0 when '' then replicate('0|',@vLimit) else @pString0 end
		,	@pString1 = case @pString1 when '' then replicate('0|',@vLimit) else @pString1 end
		,	@pString2 = case @pString2 when '' then replicate('0|',@vLimit) else @pString2 end
		,	@pString3 = case @pString3 when '' then replicate('0|',@vLimit) else @pString3 end
		,	@pString4 = case @pString4 when '' then replicate('0|',@vLimit) else @pString4 end
		,	@pString5 = case @pString5 when '' then replicate('0|',@vLimit) else @pString5 end
		,	@pString6 = case @pString6 when '' then replicate('0|',@vLimit) else @pString6 end
		,	@pString7 = case @pString7 when '' then replicate('0|',@vLimit) else @pString7 end
		,	@pString8 = case @pString8 when '' then replicate('0|',@vLimit) else @pString8 end
		,	@pString9 = case @pString9 when '' then replicate('0|',@vLimit) else @pString9 end

	while @vLimit >= @vStart
	begin
		select	@vStr0 = 'N'''+ substring(@pString0,0,charindex('|',@pString0)) +''','
			,	@vStr1 = 'N'''+ substring(@pString1,0,charindex('|',@pString1)) +''','
			,	@vStr2 = 'N'''+ substring(@pString2,0,charindex('|',@pString2)) +''','
			,	@vStr3 = 'N'''+ substring(@pString3,0,charindex('|',@pString3)) +''','
			,	@vStr4 = 'N'''+ substring(@pString4,0,charindex('|',@pString4)) +''','
			,	@vStr5 = 'N'''+ substring(@pString5,0,charindex('|',@pString5)) +''','
			,	@vStr6 = 'N'''+ substring(@pString6,0,charindex('|',@pString6)) +''','
			,	@vStr7 = 'N'''+ substring(@pString7,0,charindex('|',@pString7)) +''','
			,	@vStr8 = 'N'''+ substring(@pString8,0,charindex('|',@pString8)) +''','
			,	@vStr9 = 'N'''+ substring(@pString9,0,charindex('|',@pString9)) +''''
		select	@pString0 = substring(@pString0,charindex('|',@pString0)+1,999999999)
			,	@pString1 = substring(@pString1,charindex('|',@pString1)+1,999999999)
			,	@pString2 = substring(@pString2,charindex('|',@pString2)+1,999999999)
			,	@pString3 = substring(@pString3,charindex('|',@pString3)+1,999999999)
			,	@pString4 = substring(@pString4,charindex('|',@pString4)+1,999999999)
			,	@pString5 = substring(@pString5,charindex('|',@pString5)+1,999999999)
			,	@pString6 = substring(@pString6,charindex('|',@pString6)+1,999999999)
			,	@pString7 = substring(@pString7,charindex('|',@pString7)+1,999999999)
			,	@pString8 = substring(@pString8,charindex('|',@pString8)+1,999999999)
			,	@pString9 = substring(@pString9,charindex('|',@pString9)+1,999999999)

		select	@vSQL	+= ',('+ @vStr0 + @vStr1 + @vStr2 + @vStr3 + @vStr4 + @vStr5 + @vStr6 + @vStr7 + @vStr8 + @vStr9 +')'+ char(10)
			,	@vStart	+= 1
	end


	set @vLimit = 9
	if @vLimit >= @vSeqNo
	begin
		while @vLimit >= @vSeqNo
		begin
			select	@vTmp1	+= ',N''0'''
				,	@vTmp2	+= ',c'+ rtrim(@vSeqNo)
				,	@vSeqNo	+= 1
		end
		set @vTmp1 += ')'

		select	@vSQL	= replace(@vSQL,@vTmp1,')')
			,	@vCols	= replace(@vCols,@vTmp2,'')
	end


	set @vSQL = '
		select	*
		from	(
			values '+ stuff(@vSQL,1,1,'') +'
		) as a ('+ @vCols +')
		option (recompile)'
--	print @vSQL
	exec sp_executesql @vSQL with recompile


	return 0
end
/*
set statistics io on
use SiteManager
exec dbo.uspGetArray2Table
 @pString0 = '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|'
,@pString1 = '1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|'
,@pString2 = '10003521|10007451|10004431|10006370|10001257|10007596|10005788|10005601|10005444|10001725|10003020|10002741|10004474|10004099|10000185|10004234|10003452|10001167|10004403|10001934|10001543|10002406|10003641|10007008|10001355|10007402|'
,@pString3 = '0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|0|1|2|3|4|5|6|7|8|9|10|'
,@pString4 = '7|8|9|0|3|4|5|6|2|100|100|100|100|100|100|1|1|1|1|1|101|101|101|101|101|101|'
,@pString5 = '1|1|0|0|4|0|0|2|3|4|3|2|1|4|4|0|3|4|0|2|1|0|3|3|0|1|'
,@pString6 = '65|52|50|50|40|43|51|47|49|55|57|51|49|56|48|64|40|41|40|51|42|40|40|40|40|40|'
,@pString7 = ''
,@pString8 = ''
,@pString9 = ''
*/
go

