# encoding: utf-8

module Filters
  class CategoryCreation < ::Scrivener
    attr_accessor :name

    def validate
      assert_present :name
    end
  end
end
