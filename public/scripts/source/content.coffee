window.$ = require('jquery')

  require './other.coffee'

$ ->
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

  # load the contents for this page
  loadPage  window.location.href