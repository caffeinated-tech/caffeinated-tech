window.$ = require('jquery')

initPageManager = require './page_manager.coffee'
initAdmin = require './admin.coffee'
initEditor = require './editor.coffee'
$ ->
  initPageManager()
  initAdmin()
  initEditor()