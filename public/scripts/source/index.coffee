window.$ = require('jquery')
console.log "huzzah"


window.SERVER_URL = $('base')[0].href
window.Contents = $('#contents')

$(document).on 'click', 'a', (event) ->
  targetUrl = this.href
  toMyServer = new RegExp(SERVER_URL).test(targetUrl)
  if toMyServer 
    console.log 'overriding get to my server'
    event.preventDefault() 
    history.pushState({},'', targetUrl)

    $.ajax
      method: 'GET'
      url: targetUrl
      success: loadPageCallback


loadPageCallback = (data) ->
  console.log "loadPageCallback"
  Contents.html data

require './other.coffee'


$.ajax
  method: 'GET'
  url: window.location.href
  success: loadPageCallback