$(document).ready ->
  if Application.isRunWithin ['topics']
    $('.indented.comment .reply').hide()

    $(document).on 'mouseover', '.indented.comment', ->
      $(this).find('.reply').show()

    $(document).on 'mouseout', '.indented.comment', ->
      $(this).find('.reply').hide()
  $(document).on "click", ".wmd-preview-button", ->
    $.ajax
      type: 'POST'
      url: '/topics/preview'
      data:
        body: $("textarea").val()
      dataType: 'script'
