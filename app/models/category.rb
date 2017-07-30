class Category
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps
  include Mongoid::Pagination

  field :name, type: String
  
  has_many :questions
  #accepts_nested_attributes_for :questions
end