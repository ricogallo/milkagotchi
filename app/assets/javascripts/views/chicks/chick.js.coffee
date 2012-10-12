class Milkagotchi.Views.Chick extends Backbone.View

  template: JST['chicks/chick']
  
  className: 'row'
  
  render: ->
    $(@el).html(@template(chick: @model))
    this
  