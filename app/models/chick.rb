# encoding: UTF-8
class Chick
  include MilkagotchiSchedules
  include Mongoid::Document
  field :name, type: String
  field :food, type: Integer, default: 3
  field :toilet, type: Integer, default: 3
  field :fun, type: Integer, default: 3
  field :milk, type: Integer, default: 0
  
  attr_accessible :name
  
  validates_presence_of :name
  validates :name, length: { within: 3..16 }, allow_blank: true
  validate :maximum_number_of_chicks, on: :create
  
  HAPPY, MEH, SAD = "◕‿◕", "ఠ﹏ఠ", "ಠ︵ಠ"
  def as_json(options={})
    super options.merge(methods: :mood)
  end
  
  def mood
    attributes = [food, toilet, fun]
    if attributes.all? { |value| value >= 3 }
      HAPPY
    elsif attributes.one? { |value| value < 3 }
      MEH
    else
      SAD
    end
  end
  
  def feed
    self.update_attributes!(
      food: (self.food + 2)
    )
  end
  
  def clean
    self.update_attributes!(
      toilet: (self.toilet + 2)
    )
  end
  
  def play
    self.update_attributes!(
      food: (self.food - 1),
      toilet: (self.toilet -1),
      fun: (self.fun + 2)
    )
  end
  
  def deliver_milk
    self.update_attributes!(
      food: (self.food -1),
      toilet: (self.toilet -1),
      fun: (self.fun -1),
      milk: (self.milk + 1)
    )
  end
  
  protected
  def maximum_number_of_chicks
    if Chick.count >= 5
      errors.clear
      errors[:base] << "Upgrade today your account and spawn MOAR chicks!"
    end
  end
end
