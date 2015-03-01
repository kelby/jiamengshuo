$(document).ready ->
  if Application.isRunWithin ['topics']
    $('.indented.comment .reply').hide()

    $(document).on 'mouseover', '.indented.comment', ->
      $(this).find('.reply').show()

    $(document).on 'mouseout', '.indented.comment', ->
      $(this).find('.reply').hide()

window.Topics =
  preview: (body) ->
    $("#preview").text "Loading..."

    $.post "/topics/preview",
      "body": body,
      (data) ->
        $("#preview").html data.body
      "json"