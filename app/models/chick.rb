class Chick
  include Mongoid::Document
  field :name, type: String
  field :food, type: Integer, default: 3
  field :toilet, type: Integer, default: 2
  field :fun, type: Integer, default: 2
end
