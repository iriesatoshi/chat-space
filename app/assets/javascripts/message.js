$(function(){
  function buildHTML(message){
    var html = `<li>content_message--name${message.user.name}</li>
                <li>content_message--date${message.created_at}</li>
                <li>content_message--comment${message.body}</li>
                <li>content_message--image${image_tag message.image}</li>`
    return html;
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.content_message').append(html)
      $('.textbox').val('')
    })
    .fail(function(){
      alert('error');
    })
  })
});
