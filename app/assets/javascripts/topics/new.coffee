class @Konsento::Topic::New
  constructor: (params) ->
    @params = params

  run: ->
    @bindProposalsTextareaAutoSizeEvent()
    @bindProposalEnterPress()
    @bindProposalRemoveButtonPress()
    @bindPasteEvent()

  bindProposalsTextareaAutoSizeEvent: ->
    $('#proposals textarea').textareaAutoSize()
    $('#proposals').bind 'DOMSubtreeModified', ->
      $('#proposals textarea').textareaAutoSize()

  bindProposalEnterPress: ->
    textareaSelector = '.topic_proposals_content > textarea'

    $('#proposals').on 'keypress', textareaSelector, (e) ->
      if e.which == 13
        e.preventDefault()

        if $(@).val() != ''
          $('.add_fields').click()
          $(textareaSelector).last().focus()

  bindPasteEvent: ->
    textareaSelector = '.topic_proposals_content > textarea'
    $("#proposals").bind 'paste', textareaSelector, (e) ->
      if $("#automatically-split-text input").is(':checked')
        e.preventDefault()
        element = $('#' + e.target.id)
        pastedData = e.originalEvent.clipboardData.getData('text')
        proposals = pastedData.split('\n\n')
        if element.val().length == 0
          element.val('') #bug fixer
          element.val(proposals[0]) # add first proposal
          proposals.shift() #remove first proposal from array
        if proposals.length > 0
          for proposal in proposals
            $('#proposals .add_fields').click()
            $('#proposals textarea').last().append(proposal)
        $('#proposals textarea').trigger('input') #trigger event to auto ajust height
        $('#proposals textarea').last().focus()



  bindProposalRemoveButtonPress: ->
    $('#proposals').on 'click', '.remove_fields', (e) ->
      if $(@).parent().find('.topic_proposals_content > textarea').val() != ''
        confirm("Você perderá o que conteúdo dessa proposta.\nVocê tem certeza?")
