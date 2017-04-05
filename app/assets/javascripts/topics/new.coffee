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
        text = e.originalEvent.clipboardData.getData('text')
        proposals = text.match(/[^.\r\n]*/g)

        if proposals.length < 100
          e.preventDefault()
          element = $('#' + e.target.id)
          if element.val().length == 0
            element.val('') # bug fixer
            element.val(proposals[0]) # add first proposal
            proposals.shift() # remove first proposal from array
          if proposals.length > 0
            for proposal in proposals
              if proposal.length > 0
                $('#proposals .add_fields').click()
                $('#proposals textarea').last().append(proposal)
          $('#proposals textarea').last().focus()

      $('#proposals textarea').trigger('input') # trigger event to auto ajust height

  bindProposalRemoveButtonPress: ->
    $('#proposals').on 'click', '.remove_fields', (e) ->
      if $(@).parent().find('.topic_proposals_content > textarea').val() != ''
        confirm("Você perderá o que conteúdo dessa proposta.\nVocê tem certeza?")
