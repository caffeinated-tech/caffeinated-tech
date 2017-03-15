
$(document).on 'ready turbolinks:load', ->
  console.log 'attaching the listeners'
  $('.menu-button, #menu').on 'mouseover', (event) ->
    console.log('hover')
    $('#content').addClass 'menu-open'
  
  $('.menu-button, #menu').on 'mouseout', (event) ->
    console.log('hover out')
    $('#content').removeClass('menu-open')

$(document).on 'page:fetch', ->
  $('#content').addClass 'menu-open'
