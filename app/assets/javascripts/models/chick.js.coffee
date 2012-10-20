class Milkagotchi.Models.Chick extends Backbone.Model
  idAttribute: "_id"
  
  game_actions: ->
    [@feed, @clean, @play, @deliver_milk]
  
  feed: (opts) =>
    @custom_action("feed", opts)
    
  clean: (opts) =>
    @custom_action("clean", opts)
    
  play: (opts) =>
    @custom_action("play", opts)
    
  deliver_milk: (opts) =>
    @custom_action("deliver_milk", opts)
    
  custom_action: (action, opts) ->
    options = 
      url: @url() + "/#{action}"
      type: 'POST'
    _.extend(options, opts)
    (@sync or Backbone.sync).call(this, null, this, options)