$(document).on 'ready turbolinks:load', ->
  console.log 'attaching the listeners'
  $('.menu-button, #menu').on 'mouseover', (event) ->
    console.log('hover')
    $('#content').addClass 'disabled'
  
  $('.menu-button, #menu').on 'mouseout', (event) ->
    console.log('hover out')
    $('#content').removeClass('disabled')