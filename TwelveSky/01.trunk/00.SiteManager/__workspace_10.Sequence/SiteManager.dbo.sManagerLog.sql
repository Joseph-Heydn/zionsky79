use SiteManager
go
if object_id('dbo.sManagerLog') IS NOT NULL
begin
	print N'dbo.sManagerLog 시퀀스가 존재 합니다.'
	goto sManagerLog
	/**
		alter sequence dbo.sManagerLog restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sManagerLog'
		drop sequence dbo.sManagerLog
	**/
end

create sequence dbo.sManagerLog
start with 1
increment by 1
cache 10

sManagerLog:
go

