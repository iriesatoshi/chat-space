$(function(){
  function buildHTML(user){
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name"> ${user.name} </p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                </div>`
    return html;
  }
  $(document).on('turbolinks:load', function(){
    $(document).on('keyup', '#user-search-field', function(e){
      e.preventDefault();
      var input = $.trim($(this).val());
      $.ajax({
        url: '/users',
        type: 'GET',
        data: ('keyword=' + input),
        processData: false,
        contentType: false,
        dataType: 'json'
      })
      .done(function(data){
        $(data).each(function(i, user){
          $('#user-search-result').find('div').remove();
          var html = buildHTML(user);
          $('#user-search-result').append(html);
        })
      })
      .fail(function(){
        alert('error');
      });
    });
  });
});

$(function(){
  function buildHTML(data_name, data_id){
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-${data_id}'>
                  <input name='group[user_ids][]' type='hidden' value='${data_id}'>
                  <p class='chat-group-user__name'> ${data_name} </p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn' data-user-id="${data_id}">削除</a>
                </div>`
    return html;
  }
  $('#user-search-result').on('click', '.user-search-add', function(e){
    e.preventDefault();
   var data_name = $(this).data('userName');
   var data_id = $(this).data('userId');
      var html = buildHTML(data_name, data_id);
      $('.chat-group-user__name1').append(html);
      $('#user-search-result').find('div').remove();
  });
});

$(function(){
  $('.chat-group-user__name1').on('click', '.user-search-remove', function(e){
    e.preventDefault();
    $('.chat-group-user__name1').find('#chat-group-user-' + $(this).data('userId')).remove();
  });
});
