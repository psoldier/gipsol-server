class Question
  include Mongoid::Document
  #include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps
  include Mongoid::Pagination

  field :title, type: String
  belongs_to :category, inverse_of: :questions, counter_cache: true
  #embedded_in :category

  embeds_many :answerds
  accepts_nested_attributes_for :answerds, limit: 4
end