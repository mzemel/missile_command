class Ammo
  attr_reader :count

  def initialize(count:)
    @count = count
  end

  def empty?
    @count == 0
  end

  def decrement
    return if empty?
    @count -= 1
  end
end