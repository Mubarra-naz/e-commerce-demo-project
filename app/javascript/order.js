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

  $('#user_country').on('change', function(){
    $.ajax({
      type: 'GET',
      url: '/user/states',
      data:{
        country: $(this).val()
      },
      success: function(data){
        var opt;
        opt = '<option value="" selected>Select Your State</option>';
        if (data.length === 0) {}
        else {
          for(var i in data){
            opt += '<option value="' + i + '">' + data[i] + '</option>';
          }
          $('#user_state').html(opt);
        }
      }
    });
  });

  $('#user_state').on('change', function(){
    $.ajax({
      type: 'GET',
      url: '/user/cities',
      data:{
        country: $('#country').children(':selected').val(),
        state: $(this).val()
      },
      success: function(data){
        var opt;
        opt = '<option value="" selected>Select Your City</option>';
        if (data.length === 0) {}
        else {
          for(var i in data){
            opt += '<option value="' + i + '">' + data[i] + '</option>';
          }
          $('#user_city').html(opt);
        }
      }
    });
  });

  $('#checkout').on('click', function(){
    $('#collapse-one').removeClass('show').addClass('hide')
    $('#collapse-two').removeClass('hide').addClass('show')
  });

});
