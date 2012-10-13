class Milkagotchi.Views.Chick extends Backbone.View
  template: JST['chicks/chick']  
  className: 'row'
    
  events:
    'click .name': 'playMilkagotchi'
    'click .close': 'destroyChick'
    'hover': 'displayDestroy'
    
  initialize: ->
    @model.on('destroy', @remove, this)
    
  render: ->
    $(@el).html(@template(chick: @model))
    this
  
  playMilkagotchi: ->
    Backbone.history.navigate("play/#{@model.get('_id')}", true)
    
  destroyChick: ->
    @model.destroy wait: true
    
  displayDestroy: ->
    @$('.close').toggle()