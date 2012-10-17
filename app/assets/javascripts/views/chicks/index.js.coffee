class Milkagotchi.Views.ChicksIndex extends Backbone.View
  template: JST['chicks/index']
  
  events:
    'submit #new_chick': 'createChick'
      
  initialize: ->
    @spinnerize $('#heart')
    Milkagotchi.notifier.subscribe('chicks')
    @collection.on('reset', @render, this)
    @collection.on('add', @appendChick, this)
    @collection.on('play', @displayGame, this)
  
  render: ->
    $(@el).html(@template())
    @collection.each(@appendChick)
    this
    
  startSpinner: (element) ->
    element.fadeToggle 200, "swing", => @startSpinner element
    
  spinnerize: (element) =>
    element.ajaxStart =>
      @startSpinner element
    element.ajaxStop ->
      element.stop(true).css opacity: 1
  
  appendChick: (chick) =>
    view = new Milkagotchi.Views.Chick(model: chick)
    @$('#chick_list').prepend(view.render().el)
    
  createChick: (event) ->
    event.preventDefault()
    attributes = name: $('#new_chick_name').val().trim()
    @collection.create attributes,
      wait: true
      success: $('#new_chick')[0].reset()
      error: @handleError
  
  displayGame: (id) ->
    
  handleError: (chick, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        if attribute is "base"
          $('#modal-box').modal().find('p').html message for message in messages
        else
          alert "#{attribute} #{message}" for message in messages
        