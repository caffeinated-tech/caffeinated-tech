$ ->
  $('.menu-button, #menu').on 'mouseover', (event) ->
    console.log('hover')
    $('#content').addClass 'disabled'
  
  $('.menu-button, #menu').on 'mouseout', (event) ->
    console.log('hover out', event)
    $('#content').removeClass('disabled')