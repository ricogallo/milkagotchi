class Milkagotchi.Views.Chick extends Backbone.View
  template: JST['chicks/chick']
  
  className: 'row'

  events:
    'click .name':  'playMilkagotchi'
    'click .close': 'destroyChick'
    'hover':        'displayDestroy'
    
  initialize: ->
    @model.on('destroy', @remove, this)
    @model.on('change', @renderAnimated, this)
    
  render: ->
    $(@el).html(@template(chick: @model))
    attributes = ["food", "toilet", "fun", "milk", "mood"]
    for attribute in attributes
      @$(".details .#{attribute}").tooltip
        title: attribute
        delay:
          show: 500
          hide: 100
    this
    
  renderAnimated: ->
    @render().$el.effect 'bounce',
      times: 2
      distance: 10,
      100
    
  playMilkagotchi: ->
    id = @model.get('_id')
    Backbone.history.navigate("play/#{id}")
    @model.trigger('play', id)
    
  destroyChick: ->
    @model.destroy(wait: true)
    
  displayDestroy: ->
    @$('.close').toggle()