class Milkagotchi.Notifiers.PusherNotifier
  constructor: (appKey) ->
    _.extend(this, Backbone.Events)
    @pusher = new Pusher(appKey)
    @channels = {}
    
  subscribe: (channel) ->
    @channels[channel] = @pusher.subscribe(channel)
    @channels[channel].bind_all (event, data) =>
      @trigger(event, data)