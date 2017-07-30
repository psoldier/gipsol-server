class Answerd
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  field :text,  type: String
  field :value, type: Boolean, default: false

  embedded_in :question
end