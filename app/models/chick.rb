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
  
  after_create :set_automatic_reductions
  
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
  def set_automatic_reductions
    automatically_reduce('food', '1m')
    automatically_reduce('toilet', '3m')
    automatically_reduce('fun', '5m')
  end
end
