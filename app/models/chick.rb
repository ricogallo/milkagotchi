# encoding: UTF-8
class Chick
  include MilkagotchiSchedules
  include Mongoid::Document
  field :name, type: String
  field :food, type: Integer, default: 3
  field :toilet, type: Integer, default: 3
  field :fun, type: Integer, default: 3
  field :study, type: Integer, default: 0
  
  validates_presence_of :name
  validates :name, length: { within: 3..16 }, allow_blank: true
  validate :maximum_number_of_chicks, on: :create
  
  HAPPY, MEH, SAD = "❤‿❤", "ఠ﹏ఠ", "ಠ︵ಠ"
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
  
  protected
  def maximum_number_of_chicks
    if Chick.count >= 5
      errors.clear
      errors[:base] << "Upgrade today your account and spawn MOAR chicks!"
    end
  end
end
