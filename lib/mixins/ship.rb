# Describes behavior of a ship (defender, spaceship)
#
# #update - will move at speed and fire at weapons settings
#         - will change direction when it hits the other side
# #draw   - will draw the image specified in the class
# #top_left/bottom_right - will use WIDTH and HEIGHT from class

module Mixins
  module Ship
    def self.included(base)
      base.class_eval do
        attr_reader :x, :y, :mode, :weapons, :level, :ammo

        def initialize(x:, y:, mode:, weapons:, ammo:, level:)
          @x    = x
          @y    = y
          @mode = mode
          @weapons = weapons
          @level   = level
          @direction = [:left, :right].sample
          @ammo      = Ammo.new(count: ammo || 100)
        end 

        def update
          if @direction == :left && x == 0
            @direction = :right
          elsif @direction == :right && x == MissileCommand::WIDTH
            @direction = :left
          end
          move
          fire
        end

        def draw
          image.draw(x, y, Utility::ZIndex::DEFENDER)
        end

        def top_left
          [x, y]
        end

        def bottom_right
          [
            x + Object.const_get("#{self.class}::WIDTH"),
            y + Object.const_get("#{self.class}::HEIGHT")
          ]
        end

        private

        def speed
          @speed  ||= case mode
                      when "easy"
                        1
                      when "medium"
                        rand(3) + 1
                      when "hard"
                        rand(5) + 1
                      else
                        Utility::SPACESHIP_SPEED
                      end
        end

        def move
          @x = if @direction == :left
            [x - speed, 0].max
          else
            [x + speed, MissileCommand::WIDTH].min
          end
        end

      end
    end
  end
end