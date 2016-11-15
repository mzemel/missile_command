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

  def text
    if empty?
      "Empty"
    else
      "#{count}"
    end
  end

  def deplete
    @count = 0
  end
end