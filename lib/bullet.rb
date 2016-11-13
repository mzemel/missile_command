require_relative './mixins/projectile'

class Bullet
  include Mixins::Projectile

  DAMAGE_VALUE = 1

  def update
    if arrived?
      level.remove_bullet(self)
      level.register_explosion Explosion.new(
        x: x.floor,
        y: y.floor,
        level: level,
        projectile: self
      )
    else
      move
    end
  end
end