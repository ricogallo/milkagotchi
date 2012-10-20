module MilkagotchiScheduler
  def start_timers(chick, time_table = timers_settings)
    time_table.each do |attribute, time|
      reduce_an_attribute_every(chick, attribute, time)
    end
  end
  
  def unschedule_timers_for(chick)
    timers = find_by_tag(chick.id)
    timers.each do |timer|
      timer.unschedule
    end
  end
  
  def reduce_an_attribute_every(chick, attribute, time)
    every time, tags: [chick.id, "#{chick.id}:#{attribute}"] do |job|
      chick[attribute] -= 1
      chick.save!
    end
  end
  
  def manage(chick)
    get_timer_attributes(chick).each do |attribute, value|
      timer = find_by_tag("#{chick.id}:#{attribute}").first.o
      if value > 0
        timer.unschedule if timer
        reduce_an_attribute_every(chick, attribute, timers_settings[attribute.to_sym])
      elsif value == 0
        timer.unschedule if timer
      end
    end
  end
  
  private
  def get_timer_attributes(chick)
    GameAttributes.new(chick).timer_attributes
  end
  
  def timers_settings
    Settings.chick_timers.to_hash
  end
end