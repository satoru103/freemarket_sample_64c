$(function() {
  $(".categoryBox").hover(function() {
  $("ul.category1").toggle();
  });
  $(".categoryBox li ul").hide();
  $(".categoryBox li").hover(function() {
      $(">ul:not(:animated)", this).stop(true, true).slideDown("fast");
      $(">a", this).addClass("active");
  }, function() {
      $(">ul:not(:animated)", this).stop(true, true).slideUp("fast");
      $(">a", this).removeClass("active");
});
});