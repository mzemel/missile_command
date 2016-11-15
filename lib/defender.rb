require_relative "./mixins/ship"

class Defender
  include Mixins::Ship

  WIDTH = 30
  HEIGHT = 15
  HEALTH_COLOR = Gosu::Color.argb(0xff_ffff00)

  private

  def skin
    @skin ||= %w(x_wing y_wing a_wing).sample
  end

  def image
    if @direction == :left
      @left_image ||= Gosu::Image.new("assets/defender/#{skin}_left.png")
    else
      @right_image ||= Gosu::Image.new("assets/defender/#{skin}_right.png")
    end
  end

  def fire
    ammo.decrement
    if rand(Utility::FIRE_PROBABILITY[weapons]) == 0
      level.register_bullet Bullet.new(
        x: x,
        y: y,
        x_end: rand(MissileCommand::WIDTH),
        y_end: rand(BackgroundImage::GROUND_HEIGHT),
        level: level,
        launcher: self
      )
    end
  end
end