module.exports = ->
  subscribe = (event) ->
    event.preventDefault()
    data = 
      email: $('#mailing-list input')[0].value
    $.ajax
      method: 'POST'
      url: '/v/mailing_list/subscribe'
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(data)
      success: (response) ->
        $('#mailing-list form').hide() 
        $('#mailing-list .confirmation').show() 

  $(document).on 'submit', '#mailing-list', subscribe
  # $(document).on 'click', '#mailing-list button', subscribe

  