class Milkagotchi.Views.ChicksIndex extends Backbone.View

  template: JST['chicks/index']
  
  events:
    'submit #new_chick': 'createChick'
      
  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendChick, this)
  
  render: ->
    $(@el).html(@template())
    @collection.each(@appendChick)
    this
    
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
      
  handleError: (chick, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages