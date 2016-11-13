require_relative "./mixins/ship"

class Defender
  include Mixins::Ship

  WIDTH = 30
  HEIGHT = 15

  private

  def image
    @image ||= Gosu::Image.new("assets/defender.png")
  end

  def health_color
    Gosu::Color.argb(0xff_ffff00)
  end

  # Don't draw health bar for defenders
  def draw_health_bar; end

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