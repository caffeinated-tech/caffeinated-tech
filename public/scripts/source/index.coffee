window.$ = require('jquery')

initPageManager = require './page_manager.coffee'
initAdmin = require './admin.coffee'
initContact = require './contact.coffee'
initEditor = require './editor.coffee'
initMailingList = require './mailing_list.coffee'
$ ->
  initPageManager()
  initAdmin()
  initContact()
  initEditor()
  initMailingList()