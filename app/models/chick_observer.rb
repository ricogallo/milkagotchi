class ChickObserver < Mongoid::Observer
  def after_create(chick)
    chick.automatically_reduce(food: '1m', toilet: '3m', fun: '5m')
  end
  
  def after_update(chick)
    Pusher["chicks"].trigger("#{chick.id}-changed", chick.as_json)
  end
end
