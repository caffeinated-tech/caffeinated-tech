window.$ = require('jquery')

$ ->
  console.log "huzzah"


  window.SERVER_URL = $('base')[0].href
  window.Contents = $('#contents')

  $(document).on 'click', 'a', (event) ->
    targetUrl = this.href
    return unless this.href
    toMyServer = new RegExp(SERVER_URL).test(targetUrl)
    if toMyServer 
      console.log 'overriding get to my server'
      event.preventDefault() 
      history.pushState({},'', targetUrl)

      $.ajax
        method: 'GET'
        url: targetUrl
        success: loadPageCallback

  $(document).on 'click', 'a#add-section', (event) ->
    $('#new-content').append $('#template').html()

  $(document).on 'click', 'a#submit-post', (event) ->
    data =  
      title: $('#title')[0].value
      slug: $('#slug')[0].value
      tags: $('#tags')[0].value
      body: $('#new-content').html()
    console.log 'about to save', data, JSON.stringify(data)
    $.ajax
      method: 'POST'
      url: '/v/blog/post/new'
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify data
      success: (data) ->
        console.log 'created a new post', data

  loadPageCallback = (data) ->
    console.log "loadPageCallback"
    Contents.html data

  require './other.coffee'

  $.ajax
    method: 'GET'
    url: window.location.href
    success: loadPageCallback 