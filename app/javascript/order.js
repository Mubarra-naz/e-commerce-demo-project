$(document).on("turbolinks:load", function(){
  $('.item').on('change', function(){
    $.ajax({
      type: "POST",
      url: "/user/line_items/"+ $(this).attr('id') +"/update_qty",
      data:{
            qty: $(this).val()
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
