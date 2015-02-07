$(document).ready ->
  $('.indented.comment .reply').hide()
  return

$(document).on 'mouseover', '.indented.comment', ->
  $(this).find('.reply').show()

$(document).on 'mouseout', '.indented.comment', ->
  $(this).find('.reply').hide()
