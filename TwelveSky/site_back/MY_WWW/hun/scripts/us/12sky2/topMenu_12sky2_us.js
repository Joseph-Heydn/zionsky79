// JavaScript Document
$(document).ready(function() {

// 메뉴
$nav = $('.nav')
$anchor = $('.nav h2 a')
$navList = $('.nav div:not(.active) div.bg')
$navList2 = $('div[class*="menu"]')

function enter(){
	$navList2.each(function() {
	var sMenuImg = $(this).find('h2 a img');
		sMenuImg.attr('src', sMenuImg.attr('rel'));
	});

	var sMenuImg = $(this).find('h2 a img');
	sMenuImg.attr('src', sMenuImg.attr('rel2'));
	
	$(this)
	.find('div.bg')
	.animate({
		height : 'show',
		opacity : 0.95
	}, 100);
};

function leave(){

	var oElementArea = $('.nav div:not(.active) h2 a img');
	oElementArea.each(function() {
		$(this).attr('src', $(this).attr('rel'));
	});

	var sMenuImg = $anchor.parents('.active').find('h2 a img');
	sMenuImg.attr('src', sMenuImg.attr('rel2'));

	$navList2
	.find('div.bg')
	.animate({
		height : 'hide'
	}, 100);

};

$navList2.each(function() {
	var oElement = $(this).find('h2 a img');

	if ($(this).hasClass('active')) {
		oElement.attr("src", oElement.attr('rel2'));
	}
});


//$navList.hide(); //서브 삭제
//$navList2.bind('mouseover', enter);
//$nav.mouseleave(leave);

$navList2.bind('mouseover', enter);
$navList2.mouseleave(leave);



if (!$nav.hasClass('sub')){
	$navList.hide(); //서브 삭제
	$navList2.bind('mouseover', enter);
	$nav.mouseleave(leave);
}











});