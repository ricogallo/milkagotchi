class Milkagotchi.Routers.Chicks extends Backbone.Router
  routes:
    '': 'index'
    'play/:id': 'play'
        
  initialize: ->
    @collection = new Milkagotchi.Collections.Chicks()
    @collection.reset($('#milkagotchi').data 'chicks')
    
  index: ->
    view = new Milkagotchi.Views.ChicksIndex(collection: @collection)
    $('#milkagotchi').html(view.render().el)
  
  play: (id) ->
    alert "#{id}"