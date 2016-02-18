use AuthorityWeb
go
if object_id('dbo.sCertNo') IS NOT NULL
begin
	print N'dbo.sCertNo 시퀀스가 존재 합니다.'
	goto sCertNo
	/**
		alter sequence dbo.sCertNo restart with 1
		select name, start_value, increment, cache_size from sys.sequences where name = 'sCertNo'
		drop sequence dbo.sCertNo
	**/
end

create sequence dbo.sCertNo
start with 1
increment by 1
cache 10

sCertNo:
go

