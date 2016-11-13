class Levels::Intro
  def initialize
    @info = Gosu::Font.new(20)
  end

  def update
    @done = true if Utility.space_button?
  end

  def draw
    @info.draw("Press [Space] to start", 200, 200, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
  end

  def over?
    @done == true
  end

  def out_of_ammo?
    false
  end
end