use SiteManager
go
if object_id('dbo.sErrorNo') IS NOT NULL
begin
	print N'dbo.sErrorNo 시퀀스가 존재 합니다.'
	goto sErrorNo
	/**
		alter sequence dbo.sErrorNo restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sErrorNo'
		drop sequence dbo.sErrorNo
	**/
end

create sequence dbo.sErrorNo
start with 1
increment by 1
cache 10

sErrorNo:
go

