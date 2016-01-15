class @Konsento::Topic::Show
  constructor: (params) ->

  run: ->
    _this = @

    $('#consensus .proposal').click (e) ->
      if(e.target.tagName == 'P' || e.target.tagName == 'DIV')
        $('#consensus .proposal').removeClass('active')
        $(this).addClass('active')
        id = $(this).data('id')
        _this.loadChildren(id)
    $('#consensus .proposal')[0].click()


  loadChildren: (parentId) ->
    $.getScript "#{gon.rootUrl}js/proposals/#{parentId}/children"
