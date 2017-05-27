module.exports = ->
  $(document).on 'click', '#send-email', (event) ->
    console.log 'send'
    data = 
      sendCopy: $('#send-copy input').is(":checked")
      email: $('#email')[0].value
      name: $('#name')[0].value
      message: $('#message')[0].value
    console.log data
    $.ajax
      method: 'POST'
      url: '/v/contact/send_email'
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(data)
      success: (response) ->
        # loadPage response.url
        console.log response

  