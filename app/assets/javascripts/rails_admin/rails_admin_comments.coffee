$(document).delegate ".comment_edit_form_link", 'click', (e)->
  e.preventDefault()
  link = $(e.currentTarget)
  target = $(link.attr('href'))
  $('.comment_edit_form').addClass('hidden').closest('.comment_block').find(".content_block").removeClass('hidden')
  target.removeClass('hidden').closest('.comment_block').find(".content_block").addClass('hidden')
