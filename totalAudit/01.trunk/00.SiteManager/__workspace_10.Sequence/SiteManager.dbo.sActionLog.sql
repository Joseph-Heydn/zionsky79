use SiteManager
go
if object_id('dbo.sActionLog') IS NOT NULL
begin
	print N'dbo.sActionLog 시퀀스가 존재 합니다.'
	goto sActionLog
	/**
		alter sequence dbo.sActionLog restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sActionLog'
		drop sequence dbo.sActionLog
	**/
end

create sequence dbo.sActionLog
start with 1
increment by 1
cache 10

sActionLog:
go

