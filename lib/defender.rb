require_relative "./mixins/ship"

class Defender
  include Mixins::Ship

  WIDTH = 30
  HEIGHT = 15
  HEALTH_COLOR = Gosu::Color.argb(0xff_ffff00)

  private

  def image
    @image ||= Gosu::Image.new("assets/defender.png")
  end

  def health
    @_health  ||= case @health
                  when "medium"
                    2
                  when "high"
                    3
                  else
                    1
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