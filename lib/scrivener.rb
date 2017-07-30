class Scrivener
  def assert_filter(att, filter, error = nil)
    filter = filter.new(att)
    
    unless filter.valid?
      assert(false, error || [att, filter.errors])
    end
  end
end