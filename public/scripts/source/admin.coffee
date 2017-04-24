module.exports = ->
  $(document).on 'click', '#login', (event) ->
    data = 
      email: $('#email')[0].value
      password: $('#password')[0].value
    $.ajax
      method: 'POST'
      url: '/v/admin/login'
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(data)
      success: (response) ->
        loadPage response.url

  