$(document).ready(function(){

  $(".new-user-form").hide();

  $('.sign-up-lnk').on('click', function(){
    $(".new-user-form").toggle();
  });

});
