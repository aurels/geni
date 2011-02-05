class Array
  def tail
    self[1..(self.size-1)] || []
  end
end