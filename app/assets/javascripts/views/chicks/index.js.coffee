class Milkagotchi.Views.ChicksIndex extends Backbone.View
  template: JST['chicks/index']
  
  events:
    'submit #new-chick': 'createChick'
      
  initialize: ->
    Milkagotchi.notifier.subscribe('chicks')
    Milkagotchi.notifier.on("chick-changed", @updateChick, this)
    @spinnerize $('#heart')
    @collection.on('reset', @render, this)
    @collection.on('add', @appendChick, this)
    @collection.on('play', @displayGame, this)
  
  render: ->
    $(@el).html(@template())
    @collection.each(@appendChick)
    this
    
  startSpinner: (element) ->
    element.fadeToggle(150, "swing", => @startSpinner(element))
    
  spinnerize: (element) =>
    element.ajaxStart =>
      @startSpinner(element)
    element.ajaxStop ->
      element.stop(true).css(opacity: 1)
  
  appendChick: (chick) =>
    view = new Milkagotchi.Views.Chick(model: chick)
    @$('#chick-list').prepend view.render().el
    
  createChick: (event) ->
    event.preventDefault()
    attributes = name: $('#new-chick-name').val().trim()
    @collection.create attributes,
      wait: true
      success: $('#new-chick')[0].reset()
      error: @handleError
      
  updateChick: (data) ->
    @collection.get(data["_id"]).set(data)
  
  displayGame: (id) ->
    view = new Milkagotchi.Views.Playground(model: @collection.get(id))
    $('#playground').html(view.render().el)
    
  handleError: (chick, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        if attribute is "base"
          $('#modal-box').modal().find('p').html message for message in messages
        else
          alert("#{attribute}: #{message}") for message in messages
        