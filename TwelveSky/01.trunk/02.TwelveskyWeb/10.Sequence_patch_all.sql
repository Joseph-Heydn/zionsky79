use TwelveskyWeb
go
if object_id('dbo.sCategoryNo') IS NOT NULL
begin
	print N'dbo.sCategoryNo 시퀀스가 존재 합니다.'
	goto sCategoryNo
	/**
		alter sequence dbo.sCategoryNo restart with 10001
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sCategoryNo'
		drop sequence dbo.sCategoryNo
	**/
end

create sequence dbo.sCategoryNo
start with 10001
increment by 1
cache 10

sCategoryNo:
go

use TwelveskyWeb
go
if object_id('dbo.sCommtNo') IS NOT NULL
begin
	print N'dbo.sCommtNo 시퀀스가 존재 합니다.'
	goto sCommtNo
	/**
		alter sequence dbo.sCommtNo restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sCommtNo'
		drop sequence dbo.sCommtNo
	**/
end

create sequence dbo.sCommtNo
start with 1
increment by 1
cache 300

sCommtNo:
go

use TwelveskyWeb
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

use TwelveskyWeb
go
if object_id('dbo.sFileNo') IS NOT NULL
begin
	print N'dbo.sFileNo 시퀀스가 존재 합니다.'
	goto sFileNo
	/**
		alter sequence dbo.sFileNo restart with 7000000001
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sFileNo'
		drop sequence dbo.sFileNo
	**/
end

create sequence dbo.sFileNo
start with 7000000001
increment by 1
cache 10

sFileNo:
go

use TwelveskyWeb
go
if object_id('dbo.sMenuNo') IS NOT NULL
begin
	print N'dbo.sMenuNo 시퀀스가 존재 합니다.'
	goto sMenuNo
	/**
		alter sequence dbo.sMenuNo restart with 1000001
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sMenuNo'
		drop sequence dbo.sMenuNo
	**/
end

create sequence dbo.sMenuNo
start with 1000001
increment by 1
cache 10

sMenuNo:
go

use TwelveskyWeb
go
if object_id('dbo.sMenuType') IS NOT NULL
begin
	print N'dbo.sMenuType 시퀀스가 존재 합니다.'
	goto sMenuType
	/**
		alter sequence dbo.sMenuType restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sMenuType'
		drop sequence dbo.sMenuType
	**/
end

create sequence dbo.sMenuType
start with 1
increment by 1
cache 10

sMenuType:
go

use TwelveskyWeb
go
if object_id('dbo.sReportNo') IS NOT NULL
begin
	print N'dbo.sReportNo 시퀀스가 존재 합니다.'
	goto sReportNo
	/**
		alter sequence dbo.sReportNo restart with 1
		select name, start_value, current_value, increment, cache_size from sys.sequences where name = 'sReportNo'
		drop sequence dbo.sReportNo
	**/
end

create sequence dbo.sReportNo
start with 1
increment by 1
cache 10

sReportNo:
go

獵⁥睔汥敶歳坹扥਍潧਍晩漠橢捥彴摩✨扤⹯坳楲整潎⤧䤠⁓低⁔啎䱌਍敢楧൮ऊ牰湩⁴❎扤⹯坳楲整潎봠쓃뷶낺₡룁유듕듏⻙ധऊ潧潴猠牗瑩乥൯ऊ⨯പऊ愉瑬牥猠煥敵据⁥扤⹯坳楲整潎爠獥慴瑲眠瑩⁨റऊ猉汥捥⁴慮敭‬瑳牡彴慶畬ⱥ挠牵敲瑮癟污敵‬湩牣浥湥ⱴ挠捡敨獟穩⁥牦浯猠獹献煥敵据獥眠敨敲渠浡⁥‽猧牗瑩乥❯਍उ牤灯猠煥敵据⁥扤⹯坳楲整潎਍⨉⼪਍湥൤ഊ挊敲瑡⁥敳畱湥散搠潢献牗瑩乥൯猊慴瑲眠瑩⁨റ椊据敲敭瑮戠⁹റ挊捡敨ㄠരഊ猊牗瑩乥㩯਍潧਍਍