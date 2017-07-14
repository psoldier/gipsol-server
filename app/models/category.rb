class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Pagination

  field :name, type: String
  
  embeds_many :questions
  accepts_nested_attributes_for :questions
end