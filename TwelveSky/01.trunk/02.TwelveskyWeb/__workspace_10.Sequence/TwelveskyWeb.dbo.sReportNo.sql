use TwelveskyWeb
go
if object_id('dbo.sReportNo') IS NOT NULL
begin
	print N'dbo.sReportNo 시퀀스가 존재 합니다.'
	goto sReportNo
	/**
		alter sequence dbo.sReportNo restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sReportNo'
		drop sequence dbo.sReportNo
	**/
end

create sequence dbo.sReportNo
start with 1
increment by 1
cache 10

sReportNo:
go

