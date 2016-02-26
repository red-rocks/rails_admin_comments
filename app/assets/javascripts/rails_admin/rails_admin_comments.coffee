$(document).delegate ".comment_edit_form_link", 'click', (e)->
  e.preventDefault()
  link = $(e.currentTarget)
  target = $(link.attr('href'))
  $('.comment_edit_form').addClass('hidden')
  target.removeClass('hidden')
