class Chick
  include Mongoid::Document
  field :name, type: String
  field :food, type: Integer, default: 3
  field :toilet, type: Integer, default: 3
  field :fun, type: Integer, default: 3
  field :milk, type: Integer, default: 0
  
  validates_presence_of :name
  validates :name, length: { within: 3..12 }, allow_blank: true
  validate :maximum_number_of_chicks, on: :create
  validates_each :food, :toilet, :fun do |record, attribute, value|
    record.errors[:base] << "Invalid game action" if value > 5 || value < 0
  end
  
  def as_json(options={})
    super options.merge(methods: :mood)
  end
  
  def mood
    attributes = GameAttributes.new(self)
    Mood.from(attributes.mood_attributes).to_s
  end
  
  protected
  def maximum_number_of_chicks
    if Chick.count >= 5
      errors.clear
      errors[:base] << "Upgrade today your account and spawn MOAR chicks!"
    end
  end
end