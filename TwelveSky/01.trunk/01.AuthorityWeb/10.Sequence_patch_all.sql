use AuthorityWeb
go
if object_id('dbo.sAccountNo') IS NOT NULL
begin
	print N'dbo.sAccountNo 시퀀스가 존재 합니다.'
	goto sAccountNo
	/**
		alter sequence dbo.sAccountNo restart with 100000001
		select name, start_value, increment, cache_size from sys.sequences where name = 'sAccountNo'
		drop sequence dbo.sAccountNo
	**/
end

create sequence dbo.sAccountNo
start with 100000001
increment by 1
cache 100

sAccountNo:
go

use AuthorityWeb
go
if object_id('dbo.sBlockNo') IS NOT NULL
begin
	print N'dbo.sBlockNo 시퀀스가 존재 합니다.'
	goto sBlockNo
	/**
		alter sequence dbo.sBlockNo restart with 1
		select name, start_value, increment, cache_size from sys.sequences where name = 'sBlockNo'
		drop sequence dbo.sBlockNo
	**/
end

create sequence dbo.sBlockNo
start with 1
increment by 1
cache 10

sBlockNo:
go

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

use AuthorityWeb
go
if object_id('dbo.sErrorNo') IS NOT NULL
begin
	print N'dbo.sErrorNo 시퀀스가 존재 합니다.'
	goto sErrorNo
	/**
		alter sequence dbo.sErrorNo restart with 1
		select name, start_value, increment, cache_size from sys.sequences where name = 'sErrorNo'
		drop sequence dbo.sErrorNo
	**/
end

create sequence dbo.sErrorNo
start with 1
increment by 1
cache 10

sErrorNo:
go

