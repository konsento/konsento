class @Konsento::Topic::New
  constructor: (params) ->
    @params = params

  run: ->
    @bindProposalEnterPress()
    @bindProposalRemoveButtonPress()

  bindProposalEnterPress: ->
    textareaSelector = '.topic_proposals_content > textarea'

    $('#proposals').on 'keypress', textareaSelector, (e) ->
      if e.which == 13
        e.preventDefault()

        if $(@).val() != ''
          $('.add_fields').click()
          $(textareaSelector).last().focus()

  bindProposalRemoveButtonPress: ->
    $('#proposals').on 'click', '.remove_fields', (e) ->
      if $(@).parent().find('.topic_proposals_content > textarea').val() != ''
        confirm("Você perderá o que conteúdo dessa proposta.\nVocê tem certeza?")
