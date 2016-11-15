require_relative "../mixins/ship"

module Enemy
  class Battleship
    include Mixins::Ship

    WIDTH = 30
    HEIGHT = 35
    HEALTH_COLOR = Gosu::Color.argb(0xff_ff0000)

    private

    def health
      @_health  ||= case @health
                    when "easy"
                      20
                    when "medium"
                      50
                    when "hard"
                      100
                    when "insane"
                      200
                    else
                      20
                    end
    end

    def skin
      @skin ||= %w(slave_1 shuttle interceptor).sample
    end

    def image
      if @direction == :right
        @image_right ||= Gosu::Image.new("assets/enemies/battleship/#{skin}_right.png")
      else
        @image_left ||= Gosu::Image.new("assets/enemies/battleship/#{skin}_left.png")
      end
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