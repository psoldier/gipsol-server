# encoding: utf-8

module Filters
  class QuestionCreation < ::Scrivener
    attr_accessor :name

    def validate
      assert_present :name
    end
  end
end
