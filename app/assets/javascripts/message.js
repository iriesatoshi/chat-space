$(document).on('turbolinks:load',function(){
  function buildHTML(message){
    var html = `<li class =  "content_message--name"> ${message.user_name}</li>
                <li class = "content_message--date">${message.created_at}</li>
                <li class = "content_message--comment">${message.body}</li>
                <li class = "content_message--image>${message.image}</li>`
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
      $('.content_message').append(html);
      $('.textbox').val('');
    })
    .fail(function(){
      alert('error');
    });
  });
});

$(document).on('turbolinks:load',function(){
  function buildHTML(message) {
    var insertImage = '';
    var html = `
      <div class="message" data-message-id="${message.id}">
        <li class="content_message--name">${message.name}</li>
        <li class="content_message--date">${message.date}</li>
        <li class="content_message--comment">${message.body}</li>
        <li class="content_message--image>${message.image}</li>
      </div>`;
    return html
  }
  var interval = setInterval(function() {
    if (window.location.href.match(/\/groups\/\d+\/messages/)) {
      $.ajax({
        url: location.href.json,
      })
      .done(function(json) {
        var id = $('.message').data('messageId');
        var insertHTML = '';
        json.messages.forEach(function(message) {
          if (message.id > id ) {
            insertHTML += buildHTML(message);
          }
        });
        $('.content_message').prepend(insertHTML);
      })
      .fail(function(data) {
        alert('自動更新に失敗しました');
      });
    } else {
      clearInterval(interval);
     }} , 5000 );
});




