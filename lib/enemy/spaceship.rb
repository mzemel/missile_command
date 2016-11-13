require_relative "../mixins/ship"

module Enemy
  class Spaceship
    include Mixins::Ship

    WIDTH = 30
    HEIGHT = 15

    def image
      @image ||= Gosu::Image.new("assets/tie_advanced_1.png")
    end

    def damage!(projectile)
      @damage += projectile.damage_value
      if damage > health
        level.remove_spaceship(self, projectile)
      end
    end

    private

    def health_color
      Gosu::Color.argb(0xff_ffff00)
    end

    def fire
      if rand(Utility::FIRE_PROBABILITY[weapons]) == 0
        level.register_missile Enemy::Missile.new(
          x: x,
          y: y,
          x_end: rand(MissileCommand::WIDTH),
          y_end: MissileCommand::HEIGHT - BackgroundImage::GROUND_HEIGHT,
          level: level
        )
      end
    end
  end
end