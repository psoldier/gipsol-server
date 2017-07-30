# encoding: utf-8
module Filters
  class Answerd < Scrivener
    attr_accessor :text
    
    def validate
      assert_present :text
    end
  end
end