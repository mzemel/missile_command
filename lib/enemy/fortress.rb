require_relative "../mixins/ship"

module Enemy
  class Fortress
    include Mixins::Ship

    WIDTH = 60
    HEIGHT = 60
    HEALTH_COLOR = Gosu::Color.argb(0xff_ff00ff)

    private

    def health
      @health ||= 100
    end

    def image
      @image ||= Gosu::Image.new("assets/death_star.png")
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