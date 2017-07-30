# encoding: utf-8
module Filters
  class Question < Scrivener
    attr_accessor :title, :category_id, :answerds_attributes

    def validate
      assert_present :title
      assert_present :category_id
      assert_present :answerds_attributes
      answerds_attributes.map! do |answerd_atts|
        filter = Answerd.new(answerd_atts)
        if filter.valid?
          answerd_atts = filter.attributes
        else
          assert(false,filter.errors)
        end
      end
      assert answerds_attributes.any?{|a|a[:value]}, [:answerds_attributes,:not_valid]
    end
  end
end
