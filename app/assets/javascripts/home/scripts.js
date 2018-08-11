
function scroll_to(clicked_link, nav_height) {
  var element_class = clicked_link.attr('href').replace('#', '.');
  var scroll_to = 0;
  if(element_class != '.top-content') {
    element_class += '-container';
    scroll_to = $(element_class).offset().top - nav_height;
  }
  if($(window).scrollTop() != scroll_to) {
    $('html, body').stop().animate({scrollTop: scroll_to}, 1000);
  }
}


jQuery(document).ready(function() {

  /*
      Navigation
  */
  $('a.scroll-link').on('click', function(e) {
    e.preventDefault();
    scroll_to($(this), $('nav').height());
  });
  // toggle "navbar-no-bg" class
  $('.c-form-1-box').waypoint(function() {
    $('nav').toggleClass('navbar-no-bg');
  });

    /*
        Background slideshow
    */
    $('.top-content').backstretch("assets/home/backgrounds/1-7b2744d959c2c89492063b99fa50d561b855f552cc5aaafba1fb07771fe5dfc3.jpg");
    $('.how-it-works-container').backstretch("assets/home/backgrounds/2-c16a5d1379c0aa49198a1ac9b28c4a2714385d4456e74c79773de1518b0058eb.jpg");
    $('.testimonials-container').backstretch("assets/home/backgrounds/1-7b2744d959c2c89492063b99fa50d561b855f552cc5aaafba1fb07771fe5dfc3.jpg");
    $('.call-to-action-container').backstretch("assets/home/backgrounds/2-c16a5d1379c0aa49198a1ac9b28c4a2714385d4456e74c79773de1518b0058eb.jpg");
    $('footer').backstretch("assets/home/backgrounds/1-7b2744d959c2c89492063b99fa50d561b855f552cc5aaafba1fb07771fe5dfc3.jpg");

    $('#top-navbar-1').on('shown.bs.collapse', function(){
      $('.top-content').backstretch("resize");
    });
    $('#top-navbar-1').on('hidden.bs.collapse', function(){
      $('.top-content').backstretch("resize");
    });

    $('a[data-toggle="tab"]').on('shown.bs.tab', function(){
      $('.testimonials-container').backstretch("resize");
    });

    /*
        Wow
    */
    new WOW().init();

    /*
      Modals
  */
  $('.launch-modal').on('click', function(e){
    e.preventDefault();
    $( '#' + $(this).data('modal-id') ).modal();
  });

});

jQuery(window).load(function() {
  /*
    Hidden images
  */
  $(".modal-body img, .testimonial-image img").attr("style", "width: auto !important; height: auto !important;");
});
