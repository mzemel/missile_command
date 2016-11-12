class Bunker
  attr_reader :ammo, :key, :destroyed, :level

  WIDTH = 50
  HEIGHT = 40

  def initialize(level:, key:)
    @key       = key
    @level     = level
    @img_alive     = Gosu::Image.new("assets/bunker_#{WIDTH}_x_#{HEIGHT}.png")
    @img_destroyed = Gosu::Image.new("assets/bunker_busted.png")
    @ammo      = Ammo.new(count: 10)
    @text      = Gosu::Font.new(20)
    @destroyed = false
  end

  def update
    fire if Utility.send("#{key}_button?")
  end

  def draw
    image = @destroyed ? @img_destroyed : @img_alive 
    image.draw(*top_left, Utility::ZIndex::BUNKER)
    @text.draw(ammo.text, *text_top_left, Utility::ZIndex::BUNKER, 1.0, 1.0, 0xff_ffff00)
  end

  def top_left
    @top_left ||= [
      (MissileCommand::WIDTH - WIDTH)/2,
      MissileCommand::HEIGHT - BackgroundImage::GROUND_HEIGHT - HEIGHT
    ]
  end

  def bottom_right
    @bottom_right ||= [
      (MissileCommand::WIDTH + WIDTH)/2,
      MissileCommand::HEIGHT - BackgroundImage::GROUND_HEIGHT
    ]
  end

  def destroy
    @destroyed = true
    ammo.deplete
  end

  private

  def text_top_left
    [
      top_left[0],
      bottom_right[1] + 10
    ]
  end

  def fire
    return if Utility::Cooldown.on? || ammo.empty?
    ammo.decrement
    level.register_bullet Bullet.new(
      x: top_left[0] + WIDTH / 2,
      y: top_left[1],
      x_end: level.game.cursor.x,
      y_end: level.game.cursor.y,
      level: level
    )
    Utility::Cooldown.set
  end
end