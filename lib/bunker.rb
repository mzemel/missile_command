class Bunker
  attr_reader :bunker, :ammo, :text

  BUNKER_WIDTH = 50
  BUNKER_HEIGHT = 40

  def initialize
    @bunker = Gosu::Image.new("assets/bunker_#{BUNKER_WIDTH}_x_#{BUNKER_HEIGHT}.png")
    @ammo   = Ammo.new(count: 10)
    @text   = Gosu::Font.new(20)
  end

  def update
    fire if Utility.a_button?
  end

  def draw
    bunker.draw(*bunker_top_left, Utility::ZIndex::BUNKER)
    text.draw(ammo.text, *text_top_left, Utility::ZIndex::BUNKER, 1.0, 1.0, 0xff_ffff00)
  end

  private

  def bunker_top_left
    @bunker_top_left ||= [
      (MissileCommand::WINDOW_WIDTH - BUNKER_WIDTH)/2,
      MissileCommand::WINDOW_HEIGHT - BackgroundImage::GROUND_HEIGHT
    ]
  end

  def bunker_bottom_right
    @bunker_bottom_right ||= [
      (MissileCommand::WINDOW_WIDTH + BUNKER_WIDTH)/2,
      MissileCommand::WINDOW_HEIGHT - BackgroundImage::GROUND_HEIGHT + BUNKER_HEIGHT
    ]
  end

  def text_top_left
    [
      bunker_top_left[0],
      bunker_bottom_right[1] + 10
    ]
  end

  def fire
    return if Utility::Cooldown.on?
    ammo.decrement
    Utility::Cooldown.set
  end
end