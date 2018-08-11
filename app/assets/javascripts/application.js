// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
//
//= require jquery/jquery-3.1.1.min.js
//= require jquery_ujs
//= require frontpage/pace.min.js
//= require frontpage/wow.min.js
//= require inspinia.js
//= require frontpage/jquery.metisMenu.js
//= require frontpage/jquery.slimscroll.min.js
//= require bootstrap-sprockets

//= require emoji/emojionearea.js
//= require codemirror/codemirror
//= require codemirror/mode/javascript/javascript
//= require codemirror/mode/ruby/ruby
//= require show-hint
//= require javascript-hint
//= require javascript-more
//= require peity/jquery.peity.min.js
//= require dropzone.js
//= require cable
//= require summernote
//= require main/toastr.min.js
//= require local-time
//= require jquery_nested_form
//= require jquery.validate
//= require jquery.validate.additional-methods

//= require knowledge_items.js

$(document).on('load', function() {
  $('.summernote').summernote();

  // Minimalize menu
  $('.navbar-minimalize').on('click', function () {
      $("body").toggleClass("mini-navbar");
      SmoothlyMenu();
  });
})
