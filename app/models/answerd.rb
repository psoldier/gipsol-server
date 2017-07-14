class Answerd
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Pagination

  field :text,  type: String
  field :value, type: Boolean, default: false

  embedded_in :question
end