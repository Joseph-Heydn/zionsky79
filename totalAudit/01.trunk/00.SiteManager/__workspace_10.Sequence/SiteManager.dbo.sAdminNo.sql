use SiteManager
go
if object_id('dbo.sAdminNo') IS NOT NULL
begin
	print N'dbo.sAdminNo 시퀀스가 존재 합니다.'
	goto sAdminNo
	/**
		alter sequence dbo.sAdminNo restart with 100000001
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sAdminNo'
		drop sequence dbo.sAdminNo
	**/
end

create sequence dbo.sAdminNo
start with 100000001
increment by 1
cache 10

sAdminNo:
go

