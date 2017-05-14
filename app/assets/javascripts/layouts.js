
$(document).ready(function(){
  $('.nav_bar').css('background',"transparent");
  $(window).scroll(function(){
    console.log($(window.height));
    if ($(this).scrollTop()>150){
        $('.nav_bar').css('background', 'rgba(0,0,0,.8)').css('transition','0.3s ease-in-out');
        // $('a').css('font-size', '98%').css('transition','0.3s ease-in-out');
      }else if ($(this).scrollTop()>90){
        $('.nav_bar').css('background', 'rgba(0,0,0,0.5)').css('transition','0.3s ease-in-out');
      }else if ($(this).scrollTop()>40){
        $('.nav_bar').css('background', 'rgba(0,0,0,0.35)').css('transition','0.3s ease-in-out');
      }else{
        $('.nav_bar').css('background', 'rgba(0,0,0,0)').css('transition','0.3s ease-in-out');
        // $('a').css('font-size', '100%').css('transition','0.3s ease-in-out');
      }
  });

  //login modal
  $('.a_login').on('click', function(e){
    e.stopPropagation();
    e.preventDefault(());
    $('.login_window').fadeIn();
  });

  $('.login_form').on('click', function(e){
    e.stopPropagation();
    $('.login_window').fadeOut();
  });

  $('.login_form input').on('click', function(e){
    e.stopPropagation();
  });

  //signup modal
  $('.a_signup').on('click', function(e){
    e.stopPropagation();
    e.preventDefault();
    $('.signup_window').fadeIn();
  });

  $('.signup_form').on('click', function(e){
    e.stopPropagation();
    $('.signup_window').fadeOut();
  });

  $('.signup_form input').on('click', function(e){
    e.stopPropagation();
  });

});
