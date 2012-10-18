class Milkagotchi.Views.Playground extends Backbone.View
  template: JST['chicks/playground']
  
  tagName: "section"
  
  className: "game-ui"
    
  initialize: ->
    @model.on 'destroy', @remove, this
    Milkagotchi.notifier.on "#{@model.get('_id')}-changed", @updateChick, this
    @model.on 'change', @render, this
  
  render: ->
    $(@el).html @template(chick: @model)
    this
    
  updateChick: ->
    @model.fetch()