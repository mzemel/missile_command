require_relative '../mixins/projectile'

module Enemy
  class Missile
    include Mixins::Projectile

    WIDTH = 4
    HEIGHT = 13

    def initialize(x:, y:, x_end:, y_end:, level:)
        @image = Gosu::Image.new("assets/missile.png")
        @x     = x
        @y     = y
        @x_end = x_end
        @y_end = y_end
        @level  = level
      end

    def update
      if arrived?
        level.remove_missile(self)
      else
        move
      end
    end

    def top_left
      [x - WIDTH/2, y - HEIGHT/2]
    end

    def bottom_right
      [x + WIDTH/2, y + HEIGHT/2]
    end

    private

    def projectile_speed
      1
    end
  end
end