class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Pagination

  field :title, type: String
  embedded_in :category

  embeds_many :answerds
  accepts_nested_attributes_for :answerds
end