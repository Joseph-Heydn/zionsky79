use AuthorityWeb
go
if object_id('dbo.sDropNo') IS NOT NULL
begin
	print N'dbo.sDropNo 시퀀스가 존재 합니다.'
	goto sDropNo
	/**
		alter sequence dbo.sDropNo restart with 1
		select name, start_value, increment, cache_size from sys.sequences where name = 'sDropNo'
		drop sequence dbo.sDropNo
	**/
end

create sequence dbo.sDropNo
start with 1
increment by 1
cache 10

sDropNo:
go

