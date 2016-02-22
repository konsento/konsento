// This is a manifest file that'll be compiled into base.js, which will include all the files
// listed below.

//--- Modernizr
//= require modernizr/modernizr
//--- jQuery
//= require jquery/dist/jquery
//--- jQuery UJS
//= require jquery-ujs/src/rails
//--- Bootstrap
//= require bootstrap/dist/js/bootstrap
//--- Storage API
//= require jQuery-Storage-API/jquery.storageapi
//--- JQuery scrollTO
//= require jquery.scrollTo/jquery.scrollTo
//--- jQuery easing
//= require jquery.easing/js/jquery.easing
//--- Animo
//= require animo.js/animo
//--- Chosen
//= require chosen/chosen.jquery.min
//--- Cocoon
//= require cocoon
//--- Moment.js
//= require moment/min/moment-with-locales
//--- Bootstrap Tagsinput
//= require bootstrap-tagsinput/dist/bootstrap-tagsinput
//= require moment/min/moment-with-locales
//--- Js Auto Size
//= require textarea-autosize

$(document).ready(function(){
  moment.locale('pt-BR');

  // Initialize Chosen
  $('.chosen-select').chosen();

  $("#team_join_requirement_name").keyup(function () {
    v = $(this).val();
    $("div.each-join-requirement").each(function () {
      if($(this).find('span').text().toUpperCase().indexOf(v.toUpperCase()) < 0) {
        $(this).parent().hide();
      } else {
        $(this).parent().show();
      }
    })
  });

});
