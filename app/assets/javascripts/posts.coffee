window.Application =
  currentController: ->
    $('body').data('controller-name')

  currentAction: ->
    $('body').data('action-name')

  isRunWithin: (controllers) ->
    controllers.indexOf(Application.currentController()) >= 0

$(document).ready ->
  if Application.isRunWithin ['posts']
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


$(document).ready ->
  $(document).on 'scroll', ->
    if $(window).scrollTop() > 500
      $('.scroll-top-wrapper').addClass 'show'
    else
      $('.scroll-top-wrapper').removeClass 'show'
    return

  scrollToTop = ->
    `var scrollToTop`
    verticalOffset = if typeof verticalOffset != 'undefined' then verticalOffset else 0
    element = $('body')
    offset = element.offset()
    offsetTop = offset.top

    $('html, body').animate { scrollTop: offsetTop }, 500, 'linear'

  $('.scroll-top-wrapper').on 'click', scrollToTop
