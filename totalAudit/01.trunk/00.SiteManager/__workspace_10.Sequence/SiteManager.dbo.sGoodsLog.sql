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

