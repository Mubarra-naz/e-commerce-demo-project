$(document).on("turbolinks:load", function(){
  $('.item').on('change', function(){
    $.ajax({
      type: "POST",
      url: "/user/update_qty",
      data:{
            qty: $(this).val(),
            id: $(this).attr('id')
            },
      success: function (response){
        location.reload();
      },
      error: function (){
        alert('error');
      }
    });
  });
});
