class Milkagotchi.Views.Chick extends Backbone.View
  template: JST['chicks/chick']  
  className: 'row'

  events:
    'click .name': 'playMilkagotchi'
    'click .close': 'destroyChick'
    'hover': 'displayDestroy'
    
  initialize: ->
    Milkagotchi.notifier.on("#{@model.get('_id')}-changed", @updateChick, this)
    @model.on('destroy', @remove, this)
    @model.on('change', @render, this)
    
  render: ->
    $(@el).html(@template(chick: @model))
    attributes = ["food", "toilet", "fun", "study", "mood"]
    for attribute in attributes
      @$(".details .#{attribute}").tooltip
        title: attribute
        delay:
          show: 500
          hide: 100
    this
    
  updateChick: ->
    @model.fetch()
    
  playMilkagotchi: ->
    Backbone.history.navigate("play/#{@model.get('_id')}", true)
    
  destroyChick: ->
    @model.destroy wait: true
    
  displayDestroy: ->
    @$('.close').toggle()