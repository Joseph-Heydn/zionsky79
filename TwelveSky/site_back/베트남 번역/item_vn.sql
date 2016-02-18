T_MBER
where user_id = 'likethis79@daum.net'
and pswd = '9888547a3f923aa59f8c5a1fa8cff732'

T_MBER A
, T_MBER_INFO B
WHERE A.SEQ = B.MBER_SEQ
AND A.USE_AUTH NOT IN ('1',N'9')
AND A.USER_ID = 'likethis79@daum.net'
AND A.PSWD = '9888547a3f923aa59f8c5a1fa8cff732'
AND (CASE WHEN A.USE_AUTH = '2' THEN 'VN' ELSE B.ENTR_NAT_CD END) = 'VN'

INSERT INTO T_LOG_IN_LOGX
(    SEQ
    , USER_ID
    , LOG_IN_DTM
    , LOG_IN_RSN
)
VALUES
(
    (SELECT ISNULL(MAX(SEQ) + 1,1) FROM T_LOG_IN_LOGX)
    , 'likethis79@daum.net'
    , GETDATE()
    , '2'
)

use vn_db
go
update	b
set		b.item_nm = a.cItemName
	,	b.expl = a.cExpl
from	#tmpItemList as a
		inner join
		dbo.t_item_list as b
	on	b.seq = a.cNo
go

alter table dbo.t_item_list alter column item_nm varchar(50)
alter table dbo.t_item_list alter column expl nvarchar(300)
select max(datalength(expl)) from dbo.t_item_list

-- drop table #tmpItemList
create table #tmpItemList
(	cNo int
,	cItemName nvarchar(1000)
,	cExpl nvarchar(1000)
)
truncate table #tmpItemList
insert into #tmpItemList
values
 (17,'Pet EXP boost pill',N'<p>Nó mang lại cho vật nuôi của bạn 200% Pet EXP boost</p>')
,(18,'Title remove scroll(M)',N'<p>Hủy bỏ tiêu đề của bạn để nhận được 70%CP</p>')
,(19,'Title remove scroll(L)',N'<p>Hủy bỏ tiêu đề của bạn để nhận được 100%CP</p>')
,(20,'Stat Cleanse(L)',N'<p>Thiết lập lại một số liệu stats của bạn. Đối với Masters mức 1-33</p>')
,(21,'Stat Cleanse(M)',N'<p>Thiết lập lại một số liệu stats của bạn. Đối với 100-112</p>')
,(22,'Stat Cleanse(S)',N'<p>Thiết lập lại một số liệu stats của bạn. Đối với mức 1-99</p>')
,(23,'SkyLord&#39;s Blessed Feed',N'<p>Kích hoạt Mount cho 180 phút</p>')
,(24,'Stats Clear(XL)',N'<p>Thiết lập lại tất cả các số liệu stats (G1-G12)</p>')
,(25,'Stats Clear(L)',N'<p>Thiết lập lại tất cả các số liệu stats (M1-M33)</p>')
,(26,'Stats Clear(M)',N'<p>Thiết lập lại tất cả số liệu stats Level 100-112</p>')
,(27,'Stats Clear(S)',N'<p>Thiết lập lại tất cả các số liệu stats cho mức 1~99</p>')
,(28,'Stone of Sky',N'<p>Tiến hóa đá</p>')
,(29,'Stone of Earth',N'<p>Sự tiến hóa đá lớn</p>')
,(30,'Partial Restoration',N'<p>Giảm một khả năng võ thuật xuống 1. Sau đó phân lại skill points</p>')
,(31,'Full Restoration',N'<p>Giảm tất cả khả năng võ thuật xuống 1. Sau đó phân lại skill points</p>')
,(10,'WLC Chest',N'<p>Cơ hội để có được một WLC</p>')
,(11,'Mount Box',N'<p>Ngẫu nhiên được một mount 5%, 10% hoặc 15%</p>')
,(12,'EXP Pill(S)',N'<p>Kinh nghiệm đạt được trong 36 phút x 2</p>')
,(13,'EXP Pill(M)',N'<p>Kinh nghiệm đạt được trong 108 phút x 2</p>')
,(14,'EXP Pill(L)',N'<p>Kinh nghiệm đạt được trong 3 giờ x 2</p>')
,(1,'Name Change Scroll',N'<p>Nó thay đổi tên của bạn, đăng xuất để sử dụng, Rút Guild và sử dụng</p>')
,(2,'Faction Notice Scroll',N'<p>Bạn có thể gửi tin nhắn cho tất cả các thành viên</p>')
,(3,'Wing Protection Scroll',N'<p>Bảo vệ đôi cánh của bạn khỏi bị phá hủy khi enchant thất bại</p>')
,(4,'Full Change Scroll',N'<p>Nó thay đổi giới tính của nhân vật của bạn</p>')
,(5,'Protection Scroll',N'<p>Ngăn chặn EXP bị mất khi bị giết bởi những con quái vật trong trận đánh</p>')
,(6,'Storage Vault',N'<p>Click chuột phải để tăng kho bảo quản hàng Bank của bạn trong vòng 30 ngày</p>')
,(7,'Hermits Vault',N'<p>Click chuột phải để tăng thêm kho chứa hàng của bạn trong vòng 30 ngày</p>')
,(8,'CP Prot Charm',N'<p>Ngăn chặn mức độ giảm đi của 1 CP RFC trong mục của bạn</p>')
,(9,'Scroll of the Gods',N'<p>Điểm exp tăng gấp bốn lần khi bạn giết một cầu thủ trong PvP</p>')
,(32,'Scroll of Battle',N'<p>Điểm exp tăng gấp đôi khi bạn giết một cầu thủ trong PvP</p>')
,(33,'Scroll of Loyalty',N'<p>Tăng đóng góp gấp đôi khi bạn giết một cầu thủ trong PvP</p>')
,(34,'Protection Charm',N'<p>Bảo vệ item không bi phá hủy khi enchant thất bại</p>')
,(35,'Ceremonial Mask',N'<p>Mục trang phục</p>')
,(36,'Honor Plate',N'<p>Mục trang phục</p>')
,(37,'Honor Ward',N'<p>Mục trang phục</p>')
,(38,'Honor Greaves',N'<p>Mục trang phục</p>')
,(39,'Ritual Mask',N'<p>Mục trang phục</p>')
,(40,'Justice Plate',N'<p>Mục trang phục</p>')
,(41,'Justice Ward',N'<p>Mục trang phục</p>')
,(42,'Justice Greaves',N'<p>Mục trang phục</p>')
,(43,'Courage Mask',N'<p>Mục trang phục</p>')
,(44,'Courage Chest Armor',N'<p>Mục trang phục</p>')
,(45,'Courage Gloves',N'<p>Mục trang phục</p>')
,(46,'Valor Mask',N'<p>Mục trang phục</p>')
,(47,'Valor Chest Armor',N'<p>Mục trang phục</p>')
,(48,'Valor Abdomen Armor',N'<p>Mục trang phục</p>')
,(49,'Valor Abdomen Gloves',N'<p>Mục trang phục</p>')
,(50,'Hidden Mask',N'<p>Mục trang phục</p>')
,(51,'Eclipse Plate',N'<p>Mục trang phục</p>')
,(52,'Eclipse Ward',N'<p>Mục trang phục</p>')
,(53,'Eclipse Greaves',N'<p>Mục trang phục</p>')
,(54,'Shrouded Mask',N'<p>Mục trang phục</p>')
,(55,'Eternal Plate',N'<p>Mục trang phục</p>')
,(56,'Eternal Ward',N'<p>Mục trang phục</p>')
,(57,'Eternal Greaves',N'<p>Mục trang phục</p>')
,(58,'Twilight Mask',N'<p>Mục trang phục</p>')
,(59,'Twilight Chest Armor',N'<p>Mục trang phục</p>')
,(60,'Twilight Abdomen Armor',N'<p>Mục trang phục</p>')
,(61,'Twilight Gloves',N'<p>Mục trang phục</p>')
,(62,'Nightfall Mask',N'<p>Mục trang phục</p>')
,(63,'Nightfall Chest Armor',N'<p>Mục trang phục</p>')
,(64,'Nightfall Abdomen Armor',N'<p>Mục trang phục</p>')
,(65,'Nightfall Abdomen Armor',N'<p>Mục trang phục</p>')
,(66,'Spirit Mask',N'<p>Mục trang phục</p>')
,(67,'Rage Plate',N'<p>Mục trang phục</p>')
,(68,'Rage Ward',N'<p>Mục trang phục</p>')
,(69,'Rage Greaves',N'<p>Mục trang phục</p>')
,(70,'Ancestral Mask',N'<p>Mục trang phục</p>')
,(71,'Demonic Plate',N'<p>Mục trang phục</p>')
,(72,'Demonic Ward',N'<p>Mục trang phục</p>')
,(73,'Demonic Greaves',N'<p>Mục trang phục</p>')
,(74,'Savage Mask',N'<p>Mục trang phục</p>')
,(75,'Savage Chest Armor',N'<p>Mục trang phục</p>')
,(76,'Savage Abdomen Armor',N'<p>Mục trang phục</p>')
,(77,'Savage Gloves',N'<p>Mục trang phục</p>')
,(78,'Warlord Mask',N'<p>Mục trang phục</p>')
,(79,'Warlord Chest Armor',N'<p>Mục trang phục</p>')
,(80,'Warlord Abdomen Armor',N'<p>Mục trang phục</p>')
,(81,'Warlord Gloves',N'<p>Mục trang phục</p>')
,(82,'Fade Mask',N'<p>Mục trang phục</p>')
,(83,'Fade Wings',N'<p>Mục trang phục</p>')
,(84,'Fade Core',N'<p>Mục trang phục</p>')
,(85,'Heartless Mask',N'<p>Mục trang phục</p>')
,(86,'Heartless Wings',N'<p>Mục trang phục</p>')
,(87,'Heartless Core',N'<p>Mục trang phục</p>')
,(88,'Sunglass',N'<p>Mục trang phục</p>')
