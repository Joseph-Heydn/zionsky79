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

use SiteManager
go
if object_id('dbo.sGoodsLog') IS NOT NULL
begin
	print N'dbo.sGoodsLog 시퀀스가 존재 합니다.'
	goto sGoodsLog
	/**
		alter sequence dbo.sGoodsLog restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sGoodsLog'
		drop sequence dbo.sGoodsLog
	**/
end

create sequence dbo.sGoodsLog
start with 1
increment by 1
cache 10

sGoodsLog:
go

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

use SiteManager
go
if object_id('dbo.sTableNo') IS NOT NULL
begin
	print N'dbo.sTableNo 시퀀스가 존재 합니다.'
	goto sTableNo
	/**
		alter sequence dbo.sTableNo restart with 1000001
		select name, start_value, increment, cache_size from sys.sequences where name = 'sTableNo'
		drop sequence dbo.sTableNo
	**/
end

create sequence dbo.sTableNo
start with 1000001
increment by 1
cache 10

sTableNo:
go

