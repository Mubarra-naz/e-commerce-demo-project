$(document).on("turbolinks:load", function(){
  $('.item').on('change', function(){
    var quantity = $(this).val();
    if (quantity >= 0){
      $.ajax({
        type: "POST",
        url: "/user/line_items/"+ $(this).attr('id') +"/update_quantity",
        data:{
          qty: quantity
        },
        success: function (response){
          if (response['line_item'] != null){
            location.reload();
          } else{
            alert(response['errors']);
          }
        },
        error: function (){
          alert('Ajax request error');
        }
      });
    }
  });
});
