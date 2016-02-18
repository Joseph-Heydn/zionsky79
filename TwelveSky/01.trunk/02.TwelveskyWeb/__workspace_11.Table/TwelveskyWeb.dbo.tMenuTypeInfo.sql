use TwelveskyWeb
go
if object_id('dbo.tMenuTypeInfo') is not null
begin
	print N'dbo.tMenuTypeInfo 테이블이 존재 합니다.'
	goto tMenuTypeInfo
	/**
		alter sequence dbo.sMenuType restart with 1
		truncate table dbo.tMenuTypeInfo
		drop table dbo.tMenuTypeInfo
	**/
end

create table dbo.tMenuTypeInfo
(	cMenuType		tinyint			not null
,	cTypeName		nvarchar(10)	not null
,	cFolderName		varchar(20)		not null
,	cNote			nvarchar(50)	not null
,	cCreateTime		datetime		not null
)

-- alter table dbo.tMenuTypeInfo drop constraint PK_tMenuTypeInfo_01
alter table dbo.tMenuTypeInfo
add constraint PK_tMenuTypeInfo_01
primary key clustered
(	cMenuType
)

alter table dbo.tMenuTypeInfo add constraint DF_tMenuTypeInfo_01 default(next value for dbo.sMenuType) for cMenuType
alter table dbo.tMenuTypeInfo add constraint DF_tMenuTypeInfo_02 default(getdate()) for cCreateTime

truncate table dbo.tMenuTypeInfo
insert into dbo.tMenuTypeInfo
	(	cTypeName
	,	cFolderName
	,	cNote
	)
values
	(N'폐쇄형'		,'basic'	,N'유저가 글을 쓸수 없고, 댓글도 달수 없음')
,	(N'FAQ'			,'faq'		,N'폐쇄형이면서 리스트 내에서 오픈형으로 볼수 있음')
,	(N'이미지'		,'image'	,N'이미지')
,	(N'동영상'		,'movie'	,N'Youtube 동영상 전용')
,	(N'자유'			,'basic'	,N'자게')
,	(N'미리보기'		,'preview'	,N'글 내용의 일부를 미리 볼수 있음')
,	(N'1:1문의'		,'inquire'	,N'작성자만 볼수 있음')
,	(N'읽기전용'		,'basic'	,N'폐쇄형이나 댓글 허용')
,	(N'뷰어전용'		,'viewer'	,N'리스트를 허용하지 않고 view만 가능함')
,	(N'비게시판'		,'none'		,N'게시판 기능 없음')

tMenuTypeInfo:
go

