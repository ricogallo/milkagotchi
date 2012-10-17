class Milkagotchi.Views.Playground extends Backbone.View
  template: JST['chicks/playground']
  
  tagName: "section"
  
  className: "game-ui"
  
  render: ->
    $(@el).html @template(chick: @model)
    this