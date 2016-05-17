class @Konsento::Topic::Show
  constructor: (params) ->
    @params = params

  run: ->
    @setResizeEvent()
    $(window).resize()

    @setSectionClickEvent()
    @setConsensusNavTabEvent()

    if @params.section_index?
      $('#consensus-wrapper .section')[@params.section_index].click()
    else
      if window.innerWidth >= 768
        $('#consensus-wrapper .section')[0].click()

  setSectionClickEvent: ->
    _this = @
    $('#consensus-wrapper .section').click (e) ->
      if(e.target.tagName == 'P' || e.target.tagName == 'DIV')
        $('#consensus-wrapper .section').removeClass('active')
        $(this).addClass('active')
        topicId = $('#topic').data('topic-id')
        sectionId = $(this).data('id')
        rootTabId = $(this).parent().attr("id")
        includeSuggested = (rootTabId == "argumentation")
        _this.loadChildren(topicId, sectionId, includeSuggested)

  loadChildren: (topicId, sectionId, includeSuggested) ->
    $.getScript "#{gon.rootUrl}js/topics/#{topicId}/sections/#{sectionId}/proposals/?include_suggested=#{includeSuggested}"

  setResizeEvent: ->
    $(window).resize ->
      if($(window).width() > 976)
        margin = 100
        windowHeight = $(window).height()
        $('#consensus-wrapper').height(windowHeight - margin)
        $('#proposals').height(windowHeight - margin)
      else
        #sadasd

  setConsensusNavTabEvent: ->
    $('#consensus-pagination').hide();
    $('#consensus-nav-tabs a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
      target = $(e.target).attr('href')
      # activated tab
      $('#argumentation-pagination, #consensus-pagination').hide();
      $(target+"-pagination").show();
      return
