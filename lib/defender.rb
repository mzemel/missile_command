require_relative "./mixins/ship"

class Defender
  include Mixins::Ship

  WIDTH = 30
  HEIGHT = 15

  def image
    @image ||= Gosu::Image.new("assets/defender.png")
  end

  def damage
    level.remove_defender(self)
  end

  private

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