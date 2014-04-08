# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
changes =
  humanReadableExpiry: ->
    $('.expiry').each ->
      this.innerHTML = moment(this.innerHTML).fromNow()

  hideJumbo: ->
    $('.banner').hide()
    $('.jumbotron')
      .css('padding-bottom', '0')
      .css('padding-top', '0')

  searching: ->
    $('#search').keyup ->
      changes.hideJumbo()
      searchTerm = this.value
      $('tr').show()

      for i in $('.domain')
        if (i.innerHTML).indexOf(searchTerm) is -1
          $(i).parent().parent().hide()

do (changes) ->
  $ ->
    changes.searching()
    changes.humanReadableExpiry()
    $('#action').click (e) ->
      e.stopPropagation()
      changes.hideJumbo()
