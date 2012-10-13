# encoding: UTF-8
class Chick
  include Mongoid::Document
  field :name, type: String
  field :food, type: Integer, default: 3
  field :toilet, type: Integer, default: 3
  field :fun, type: Integer, default: 2
  field :study, type: Integer, default: 0
  
  validates_presence_of :name
  validates :name, length: { within: 3..20 }, allow_blank: true
  
  def as_json(options={})
    super options.merge(methods: :mood)
  end
  
  def mood
    attributes = [food, toilet, fun]
    if attributes.all? { |value| value >= 3 }
      "^_^"
    elsif attributes.one? { |value| value < 3 }
      "°_°"
    else
      "-_-"
    end
  end
end
