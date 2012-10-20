class GameAttributes
  def initialize(chick)
    @attributes = chick.attributes
  end
  
  def mood_attributes
    reject_if_not_included([:food, :toilet, :fun], @attributes)
  end
  
  def timer_attributes
    reject_if_not_included(Settings.chick_timers.to_hash, @attributes)    
  end
  
  private
  def reject_if_not_included(array, attributes)
    attributes.reject do |attribute, value|
      not array.include? attribute.to_sym
    end
  end
end