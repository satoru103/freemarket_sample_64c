$(function () {
  $('.mypage-list--info').click(function () {
    $('.tab-list-info').show();
    $('.tab-list-todo').hide();
  });

  $('.mypage-list--todo').click(function () {
    $('.tab-list-todo').show();
    $('.tab-list-info').hide();
  });

  $('.goods-purchase--transaction').click(function () {
    $('.tab-list--transaction').show();
    $('.tab-list--post').hide();
  });

  $('.goods-purchase--post').click(function () {
    $('.tab-list--post').show();
    $('.tab-list--transaction').hide();
  });

});