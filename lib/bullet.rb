require_relative './projectile'

class Bullet
  include Projectile

  def update
    if arrived?
      level.remove_bullet(self)
      level.register_explosion Explosion.new(
        x: x.floor,
        y: y.floor,
        level: level
      )
    else
      move
    end
  end
end