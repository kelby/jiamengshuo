# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#more_content").hide()
$("#more_opt").click ->
  $("#more_content").slideToggle "slow", ->

  return
