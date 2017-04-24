# public constants

window.SERVER_URL = $('base')[0].href
window.CONTENTS = $('#contents')
window.CURRENT_SECTION = null

# public method

window.loadPage = (url) ->
  history.pushState({},'', url)
  CONTENTS.html 'loading...'
  changePageStyle url
  $.ajax
    method: 'GET'
    url: url
    success: loadPageCallback
  
# private methods

loadPageCallback = (data) ->
  CONTENTS.html data
  if CONTENTS.find('#editor').length > 0
    window.Editor.initialize()
  $('pre code').each (i, e) -> 
    hljs.highlightBlock e

loadMoreCallback = (data) ->
  CONTENTS.find('.bottom').before data

changePageStyle = (url) ->
  window.CURRENT_SECTION = switch 
    when /blog/.test url then 'blog'
    when /glossary/.test url then 'glossary'
    when /contact/.test url then 'contact'
    when /CV/.test url then 'profile'
    else 'home'
  console.log 'CURRENT_SECTION', CURRENT_SECTION
  CONTENTS[0].className = CURRENT_SECTION

# initializer
module.exports = ->
  doc = $(document)

  # manage loading links as spa app ajax requests
  doc.on 'click', 'a', (event) ->
    targetUrl = this.href
    return unless this.href
    return unless new RegExp(SERVER_URL).test(targetUrl)

    event.preventDefault() 
    loadPage targetUrl

  doc.on 'click', 'a#load-more', (event) ->
    currentNumberOfPosts = CONTENTS.find('.section').length
    $.ajax
      method: 'GET'
      url: "v/#{CURRENT_SECTION}/more?count=#{currentNumberOfPosts}"
      success: loadMoreCallback


  # load the contents for this page
  loadPage  window.location.href