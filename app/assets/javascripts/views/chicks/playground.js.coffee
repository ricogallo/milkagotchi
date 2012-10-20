class Milkagotchi.Views.Playground extends Backbone.View
  template: JST['chicks/playground']
  
  tagName: "section"
  
  className: "game-ui"
    
  events:
    "click .right": "goRight"
    "click .ok": "confirm"
    "click .escape": "escape"
    "mouseenter #mood": "closeEyes"
    "mouseleave #mood": "openEyes"
    "mouseenter .btn": "btnActive"
    "mouseleave .btn": "btnInactive"
      
  initialize: ->
    @model.on('destroy', @removeAndSetBgBack, this)
    @model.on('change', @render, this)
    
  render: ->
    @hideBackGround()
    $(@el).html(@template(chick: @model))
    this
      
  hideBackGround: ->
    @background = $('#playground').css('background-image')
    $('#playground').css('background-image': 'none')
    
  removeAndSetBgBack: (chick) ->
    if Backbone.history.fragment.match(@model.get('_id'))
      $('#playground').css('background-image': 'url(/assets/milk.png)')
    @remove()
    
  goRight: (event) ->
    switch @navigationCounter ?= 0
      when 0 then @activate $('#food-metric')
      when 1 then @activate $('#toilet-metric')
      when 2 then @activate $('#fun-metric')
      when 3 then @activate $('#milk-metric')            
    if @navigationCounter <= 3 then @navigationCounter++ else @navigationCounter = 0
    @activateBtns()
    
  confirm: (event) ->
    if @navigationCounter
      actions = @model.game_actions()
      actions[@navigationCounter-1]()
      @disableBtns()
    
  escape: (event) ->
    @$('.progress').removeClass('active')
    @$('p').css('font-weight': 'normal', 'color': '#333')
    @disableBtns()    
    
  activate: (element)->
    @$('.progress').removeClass('active')
    element.find('.progress').addClass('active')
    @$('p').css('font-weight': 'normal', 'color': '#333')
    element.find('p').css('font-weight': 'bold', 'color': '#BF0000')
    
  closeEyes: (event) =>
    target = $(event.currentTarget)
    target.html("-#{@model.get('mood')[1]}-")

  openEyes: (event) =>
    target = $(event.currentTarget)
    target.html(@model.get('mood'))
    
  btnActive: (event) ->
    target = $(event.currentTarget)
    target.css("color": "#BF0000")
    
  btnInactive: (event) ->
    target = $(event.currentTarget)
    target.css("color": "#333")  
    
  disableBtns: ->
    @navigationCounter = null
    @$('.escape').addClass('disabled')
    @$('.ok').addClass('disabled')
    
  activateBtns: ->
    @$('.escape').removeClass('disabled')
    @$('.ok').removeClass('disabled')