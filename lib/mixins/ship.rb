# Describes behavior of a ship (defender, spaceship, battleship)
#
# #update - will move at speed and fire at weapons settings
#         - will change direction when it hits the other side
# #draw   - will draw the image specified in the class
# #top_left/bottom_right - will use WIDTH and HEIGHT from class
# #damage! - will handle removing the object from the level

module Mixins
  module Ship
    def self.included(base)
      base.class_eval do
        attr_reader :x,
                    :y,
                    :mode,
                    :weapons,
                    :level,
                    :ammo,
                    :damage

        def initialize(x:, y:, mode:, weapons:, ammo:, health:, level:)
          @x         = x
          @y         = y
          @mode      = mode
          @weapons   = weapons
          @ammo      = Ammo.new(count: ammo || 100)
          @health    = health
          @level     = level
          @direction = [:left, :right].sample
          @damage    = 0
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
          draw_health_bar
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

        def damage!(projectile)
          @damage += projectile.damage_value
          if damage > health
            method = "#{self.class}".split('::').last.downcase
            level.send("remove_#{method}", self, projectile)
          end
        end

        private

        def draw_health_bar
          return if health == 1
          health_percent = 1.0 - damage.to_f / health
          bar_length = Object.const_get("#{self.class}::WIDTH") * health_percent
          Gosu.draw_line(x, y - 4, health_color, x + bar_length, y - 4, health_color, Utility::ZIndex::HEALTH_BAR, :default)
        end

        def health
          @_health  ||= case @health
                        when "easy"
                          1
                        when "medium"
                          20 # 2 direct hits
                        when "hard"
                          50 # 3-4 direct hits
                        when "insane"
                          100 # 6-8 direct hits
                        else
                          1
                        end
        end

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