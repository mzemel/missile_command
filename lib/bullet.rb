require_relative './mixins/projectile'

class Bullet
  include Mixins::Projectile

  def update
    if arrived?
      level.remove_bullet(self)
      level.register_explosion Explosion.new(
        x: x.floor,
        y: y.floor,
        level: level,
        bullet: self
      )
    else
      move
    end
  end
end