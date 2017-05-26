
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

  //general modal function ----------------------------------------------------

  function modal(link, mask, form, input) {
    var schedule_id;
    link.on('click', function(e){
      e.stopPropagation();
      e.preventDefault();
      mask.fadeIn();
      if (link === bookingLink) {
      schedule_id = this.id.substring(1,this.id.length);
      $(".new_booking").attr('action','/tours/70/schedules/'+ schedule_id +'/bookings');
      }
    });

    mask.on('click', function(e){
      e.preventDefault();
      mask.fadeOut();
    });

    form.on('click', function(e){
      e.stopPropagation();

    });

    input.on('click', function(e){
      e.stopPropagation();
    });

  }

  //login modal ---------------------------------------------------------------

  var loginLink    = $('.a_login');
  var loginMask    = $('.login_window');
  var loginForm    = $('.login_form');
  var loginInput   = $('.login_form input');

  modal(loginLink, loginMask, loginForm, loginInput);

//booking form modal ---------------------------------------------------------

  var bookingLink  = $('.booking-button');
  var bookingMask  = $('.booking-modal-window');
  var bookingForm  = $('.booking-modal-form');
  var bookingInput = $('.booking-modal-form input');

  modal(bookingLink, bookingMask, bookingForm, bookingInput);

  //schedules modal (non-responsive) ------------------------------------------

  var schedulesLink  = $('.tour-show-all');
  var schedulesMask  = $('.schedules-modal-window');
  var schedulesForm  = $('.schedules-modal');
  var schedulesInput = $('.schedules-modal');

  modal(schedulesLink, schedulesMask, schedulesForm, schedulesInput);


  //schedules modal (responsive) ------------------------------------------

  var responsiveLink  = $('.tour-show-responsive');
  var responsiveMask  = $('.schedules-modal-window-responsive')
  var responsiveForm  = $('.schedules-modal-responsive')
  var responsiveInput = $('.schedules-modal-responsive')

  modal(responsiveLink, responsiveMask, responsiveForm, responsiveInput);



  // close all modals on esc key ----------------------------------------------

  $(document).keyup(function(event){
      if(event.which=='27'){
        $('.login_window').fadeOut();
        $('.schedules-modal-window').fadeOut();
        $('.booking-modal-window').fadeOut();
        $('.schedules-modal-window-responsive').fadeOut();
      }
    });

});
