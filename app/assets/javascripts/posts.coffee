$(document).ready ->
  if $('input#post_icon_fi').val().length > 0
    $('input#post_icon_fa').prop("disabled", true)

  if $('input#post_icon_fa').val().length > 0
    $('input#post_icon_fi').prop("disabled", true)

  $(document).on 'focus', 'input#post_icon_fi', ->
    $('input#post_icon_fa').prop("disabled", true)

  $(document).on 'blur', 'input#post_icon_fi', ->
    if $(this).val().length == 0
      $('input#post_icon_fa').prop("disabled", false)

  $(document).on 'focus', 'input#post_icon_fa', ->
    $('input#post_icon_fi').prop("disabled", true)

  $(document).on 'blur', 'input#post_icon_fa', ->
    if $(this).val().length == 0
      $('input#post_icon_fi').prop("disabled", false)

  $("#more_content").hide()
  $("#more_opt").click ->
    $("#more_content").slideToggle "slow", ->

    return