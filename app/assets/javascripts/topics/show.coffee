class @Konsento::Topic::Show
  constructor: (params) ->

  run: ->
    @setSectionClickEvent()
    $('#consensus .section')[0].click()

  setSectionClickEvent: ->
    _this = @
    $('#consensus .section').click (e) ->
      if(e.target.tagName == 'P' || e.target.tagName == 'DIV')
        $('#consensus .section').removeClass('active')
        $(this).addClass('active')
        topicId = $('#topic').data('topic-id')
        sectionId = $(this).data('id')
        _this.loadChildren(topicId, sectionId)

  loadChildren: (topicId, sectionId) ->
    $.getScript "#{gon.rootUrl}js/topics/#{topicId}/sections/#{sectionId}/proposals"
