# encoding: utf-8
module Filters
  class Question < Scrivener
    attr_accessor :title, :category_id, :answerds_attributes

    def validate
      assert_present :title
      assert_present :category_id
      assert_present :answerds_attributes
      answerds_attributes.each do |answerd_atts|
        assert_filter answerd_atts, Answerd
      end
    end
  end
end
