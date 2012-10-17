class Milkagotchi.Routers.Chicks extends Backbone.Router
  routes:
    "": "index"
    "play/:id": "index"
    "*default": "defaultRoute"
    
  initialize: ->
    @collection = new Milkagotchi.Collections.Chicks()
    @collection.reset($('#milkagotchi').data 'chicks')
    
  index: (id) ->
    view = new Milkagotchi.Views.ChicksIndex(collection: @collection)
    $('#milkagotchi').html(view.render().el)
    @collection.trigger('play', id) if id
    
  defaultRoute: ->
    @index()