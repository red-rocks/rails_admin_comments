$(document).delegate ".comment_edit_form_link", 'click', (e)->
  e.preventDefault()
  link = $(e.currentTarget)
  target = $(link.attr('href'))
  $('.comment_edit_form').addClass('hidden').closest('.comment_block').find(".content_block").removeClass('hidden')
  target.removeClass('hidden').closest('.comment_block').find(".content_block").addClass('hidden')


$(document).delegate ".comment_delete_form_link", 'click', (e)->
  e.preventDefault()
  link = $(e.currentTarget)
  target = $(link.attr('href'))
  target.find('form').prepend("<input type='hidden' name='_method' value='delete'></input>").submit()


$(document).delegate ".comment_mark_read_form_link", 'click', (e)->
  e.preventDefault()
  link = $(e.currentTarget)
  target = $(link.attr('href'))
  target.find('form').prepend("<input type='hidden' name='mark_read' value='1'></input>").submit()


$(document).delegate ".comment_mark_all_read_link", 'click', (e)->
  e.preventDefault()
  link = $(e.currentTarget)
  $.post(link.data('url'), {comment_ids: (link.data('comment-ids') || "").split(","), mark_all_read: '1'}, ->
    location.reload()
  )
