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
      loadPage targetUrl

  $(document).on 'click', 'a#add-section', (event) ->
    $('#new-content').append $('#section-template').html()

  $(document).on 'click', 'a#add-code', (event) ->
    $('#new-content').append $('#code-template').html()

  $(document).on 'click', 'a#load-more-posts', (event) ->
    currentNumberOfPosts = Contents.find('.section').length
    $.ajax
      method: 'GET'
      url: "v/blog/more?count=#{currentNumberOfPosts}"
      success: loadMoreCallback

  $(document).on 'click', 'a#load-more-defintions', (event) ->
    currentNumberOfDefinitions = Contents.find('.section').length
    $.ajax
      method: 'GET'
      url: "v/glossary?count=#{currentNumberOfDefinitions}"
      success: loadMoreCallback

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
        console.log 'logged in', response
        loadPage response.url

  
  $(document).on 'click', 'a#submit-post', (event) ->
    data =  
      title: $('#title')[0].value
      author: $('#author')[0].value
      blurb: $('#blurb')[0].value
      tags: $('#tags')[0].value
      body: $('#new-content').html()
    
    $.ajax
      method: 'POST'
      url: '/v/blog/new'
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(data)
      success: (response) ->
        console.log 'created a new post', response
        loadPage response.url

  $(document).on 'click', 'a#submit-definition', (event) ->
    data =  
      title: $('#title')[0].value
      author: $('#author')[0].value
      blurb: $('#blurb')[0].value
      tags: $('#tags')[0].value
      body: $('#new-content').html()
    
    $.ajax
      method: 'POST'
      url: '/v/glossary/new'
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(data)
      success: (response) ->
        console.log 'created a new definition', response
        loadPage response.url
  
  loadPage = (url) ->
    history.pushState({},'', url)
    Contents.html 'loading...'
    changePageStyle url
    $.ajax
      method: 'GET'
      url: url
      success: loadPageCallback
    
  loadPageCallback = (data) ->
    console.log "loadPageCallback"
    Contents.html data
    $('pre code').each (i, e) -> 
      console.log 'highglighting block ', e
      hljs.highlightBlock e


  loadMoreCallback = (data) ->
    Contents.find('.bottom').before data

  changePageStyle = (url) ->
    console.log 'changePageStyle', url
    klass = switch 
      when /blog/.test url then 'blog'
      when /glossary/.test url then 'glossary'
      when /contact/.test url then 'contact'
      when /CV/.test url then 'profile'
      else 'home'
    console.log 'klass', klass
    Contents[0].className = klass
  require './other.coffee'

  loadPage  window.location.href