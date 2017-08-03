# encoding: utf-8
module Filters
  class Category < Scrivener
    attr_accessor :name, :source_name

    def validate
      assert_present :name
      assert_present :source_name
    end
  end
end
