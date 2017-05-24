
$(document).ready(function(){
  // $('.nav_bar').css('background',"transparent");
  // $(window).scroll(function(){
  //
  //   if ($(this).scrollTop()>150){
  //       $('.nav_bar').css('background', 'rgba(0,0,0,.8)').css('transition','0.3s ease-in-out');
  //       // $('a').css('font-size', '98%').css('transition','0.3s ease-in-out');
  //     }else if ($(this).scrollTop()>90){
  //       $('.nav_bar').css('background', 'rgba(0,0,0,0.5)').css('transition','0.3s ease-in-out');
  //     }else if ($(this).scrollTop()>40){
  //       $('.nav_bar').css('background', 'rgba(0,0,0,0.35)').css('transition','0.3s ease-in-out');
  //     }else{
  //       $('.nav_bar').css('background', 'rgba(0,0,0,0)').css('transition','0.3s ease-in-out');
  //       // $('a').css('font-size', '100%').css('transition','0.3s ease-in-out');
  //     }
  // });



  //login modal

  function modal(link, mask, form, input) {
    link.on('click', function(e){
      e.stopPropagation();
      e.preventDefault();
      mask.fadeIn();
    });

    mask.on('click', function(e){
      e.preventDefault();
      mask.fadeOut();
    });

    form.on('click', function(e){
      e.stopPropagation();
      e.preventDefault();
    });

    input.on('click', function(e){
      e.stopPropagation();
    });

  }

  var loginLink    = $('.a_login')
  var loginMask    = $('.login_window')
  var loginForm    = $('.login_form')
  var loginInput   = $('.login_form input')

  modal(loginLink, loginMask, loginForm, loginInput);




  $(document).keyup(function(event){
      if(event.which=='27'){
        $('.login_window').fadeOut();
        $('.schedules-modal-window').fadeOut();
        $('.booking-modal-window').fadeOut();
      }
    });



});
