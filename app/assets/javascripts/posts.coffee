$(document).ready ->
  $(document).on 'focus', 'input#post_fi_icon', ->
    $('input#post_fa_icon').prop("disabled", true)
    $("input#post_icon_from").val('1')

  $(document).on 'blur', 'input#post_fi_icon', ->
    if $(this).val().length == 0
      $('input#post_fa_icon').prop("disabled", false)
      $("input#post_icon_from").val('')

  $(document).on 'focus', 'input#post_fa_icon', ->
    $('input#post_fi_icon').prop("disabled", true)
    $("input#post_icon_from").val('2')

  $(document).on 'blur', 'input#post_fa_icon', ->
    if $(this).val().length == 0
      $('input#post_fi_icon').prop("disabled", false)
      $("input#post_icon_from").val('')
