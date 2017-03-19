window.$ = require('jquery')

$ ->
  console.log "huzzah"


  window.SERVER_URL = $('base')[0].href
  window.Contents = $('#contents')

  $(document).on 'clickpushState', 'a', (event) ->
    targetUrl = this.href
    return unless this.href
    toMyServer = new RegExp(SERVER_URL).test(targetUrl)
    if toMyServer 
      console.log 'overriding get to my server'
      event.preventDefault() 
      loadPage targetUrl

  $(document).on 'click', 'a#add-section', (event) ->
    $('#new-content').append $('#template').html()

  $(document).on 'click', 'a#load-more-posts', (event) ->
    currentNumberOfPosts = Contents.find('.section').length
    $.ajax
      method: 'GET'
      url: "v/blog/more?count=#{currentNumberOfPosts}"
      success: loadMoreCallback
  
  $(document).on 'click', 'a#submit-post', (event) ->
    data =  
      title: $('#title')[0].value
      author: $('#author')[0].value
      blurb: $('#blurb')[0].value
      tags: $('#tags')[0].value
      body: $('#new-content').html()
    console.log 'about to save'
    
    $.ajax
      method: 'POST'
      url: '/v/blog/post/new'
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(data)
      success: (response) ->
        console.log 'created a new post', response
        loadPage response.url
  
  loadPage = (url) ->
    history.pushState({},'', url)
    $.ajax
      method: 'GET'
      url: url
      success: loadPageCallback
    
  loadPageCallback = (data) ->
    console.log "loadPageCallback"
    Contents.html data
  loadMoreCallback = (data) ->
    Contents.find('.bottom').before data

  require './other.coffee'

  loadPage  window.location.href