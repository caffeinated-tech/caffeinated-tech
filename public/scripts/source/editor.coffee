window.SimpleMDE = require 'simplemde'
window.Editor = {}
METADATA_KEYS = ['title', 'blurb', 'tags']

module.exports = ->

  $(document).on 'click', 'a#save', (event) ->
    body = window.Editor.simpleMDE.value()
    [metadata, body] = body.split("----")
    data =
      body: body
    # parse metadata out of post body
    for line in metadata.split("\n")
      vals = line.split('=')
      [key, value] = (val.trim() for val in vals)
      continue unless key in METADATA_KEYS
      data[key] = value
    console.log 'current id', CURRENT_ID  
    console.log data

    to_update = if CURRENT_ID is null
      'new'
    else
      CURRENT_ID
    
    $.ajax
      method: 'POST'
      url: "/v/#{CURRENT_SECTION}/#{to_update}"
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(data)
      success: (response) ->
        console.log "created a new #{CURRENT_SECTION}", response
        loadPage response.url

  $(document).on 'click', 'a#edit-definition', (event) ->
    console.log "cicked on edit definition"
    console.log $('#_id')[0].value
    _id = $('#_id')[0].value
    data =  
      title: $('#title')[0].value
      author: $('#author')[0].value
      blurb: $('#blurb')[0].value
      tags: $('#tags')[0].value
      body: $('#new-content').html()
    
    $.ajax
      method: 'POST'
      url: "/v/glossary/edit/#{_id}"
      dataType: "json"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify(data)
      success: (response) ->
        console.log 'updated a definition', response
        loadPage response.url

  window.Editor.initialize = ->
    textarea = $(document).find('#editor textarea')[0]
    text = textarea.value
    window.Editor.simpleMDE = new SimpleMDE
      autofocus: true
      autosave: true
      element: textarea
      hideIcons: ['heading', 'fullscreen', 'preview']
      indentWithTabs: false
      initialValue: text
      showIcons: ['heading-2','heading-3','heading-4',
        'code', 'code', 'side-by-side']
      spellChecker: true

    window.Editor.simpleMDE.toggleSideBySide()
    setTimeout ->
      window.Editor.simpleMDE.toggleSideBySide()
    ,0
