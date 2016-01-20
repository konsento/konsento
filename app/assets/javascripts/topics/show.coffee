class @Konsento::Topic::Show
  constructor: (params) ->

  run: ->
    @setProposalsClickEvent()
    $('#consensus .proposal')[0].click()

  setProposalsClickEvent: ->
    _this = @
    $('#consensus .proposal').click (e) ->
      if(e.target.tagName == 'P' || e.target.tagName == 'DIV')
        $('#consensus .proposal').removeClass('active')
        $(this).addClass('active')
        topicId = $('#topic').data('topic-id')
        proposalIndex = $(this).data('proposal-index')
        _this.loadChildren(topicId, proposalIndex)

  loadChildren: (topicId, proposalIndex) ->
    $.getScript "#{gon.rootUrl}js/proposals/#{topicId}/#{proposalIndex}"
