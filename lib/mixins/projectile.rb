# Exposes 2 private methods to classes that include it
#
# #arrived? - has the projectile reached its target?
# #move - move the projectile towards its target at projectile_speed

module Mixins
  module Projectile
    def self.included(base)
      base.class_eval do
        attr_reader :image, :x, :y, :x_end, :y_end, :level, :launcher

        def initialize(x:, y:, x_end:, y_end:, level:, launcher:)
          @image = Gosu::Image.new("assets/bullet.png")
          @x     = x
          @y     = y
          @x_end = x_end
          @y_end = y_end
          @level  = level
          @launcher = launcher
        end

        def draw
          image.draw(x, y, Utility::ZIndex::PROJECTILE)
        end

        private

        def arrived?
          (x_end.floor - x.floor).abs <= Utility::PROJECTILE_PROXIMITY &&
            (y_end.floor - y.floor).abs <= Utility::PROJECTILE_PROXIMITY
        end

        # Overload as necessary
        def projectile_speed
          Utility::PROJECTILE_SPEED
        end

        def move
          hypotenuse = Math.sqrt((x - x_end)**2 + (y - y_end)**2)

          x_per_frame = ((x - x_end).abs / hypotenuse) * projectile_speed
          y_per_frame = ((y - y_end).abs / hypotenuse) * projectile_speed

          if x > x_end
            @x = (x - x_per_frame)
          elsif x < x_end
            @x = (x + x_per_frame)
          else
            # do nothing
          end

          if y > y_end
            @y = (y - y_per_frame)
          elsif y < y_end
            @y = (y + y_per_frame)
          else
            # do nothing
          end
        end
      end
    end
  end
end