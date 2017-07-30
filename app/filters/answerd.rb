# encoding: utf-8
module Filters
  class Answerd < Scrivener
    attr_accessor :id, :text, :value
    
    def validate
      assert_present :text
      #assert_present :value
    end

    def attributes
      atts = super.delete_if { |k,v| (k == :id && v.to_s.empty?) }
      atts.merge(value: atts[:value] == "on")
    end
  end
end