use SiteManager
go
if object_id('dbo.sRecoreryLog') IS NOT NULL
begin
	print N'dbo.sRecoreryLog 시퀀스가 존재 합니다.'
	goto sRecoreryLog
	/**
		alter sequence dbo.sRecoreryLog restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sRecoreryLog'
		drop sequence dbo.sRecoreryLog
	**/
end

create sequence dbo.sRecoreryLog
start with 1
increment by 1
cache 10

sRecoreryLog:
go

