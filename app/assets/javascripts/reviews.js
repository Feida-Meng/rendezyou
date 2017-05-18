$(function(){
  $('.reviews-star-ratings').each(function(){
    var starCount = parseInt($(this).html());
      $(this).html("");
    for (var i = 0; i < starCount; i++) {
      $(this).append("<span class='fa fa-star'>");
      // ("<span class='fa fa-star'>");
      // span.addClass("fa-star");
    }
  });






  });
