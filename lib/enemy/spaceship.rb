module Enemy
  class Spaceship
    attr_reader :x, :y, :direction

    WIDTH = 30
    HEIGHT = 15

    def initialize(x:, y:)
      @x = x
      @y = y
      @direction = :left
      @image = Gosu::Image.new("assets/spaceship.png")
    end

    def update
      if direction == :left && x == 0
        @direction = :right
      elsif direction == :right && x == MissileCommand::WINDOW_WIDTH
        @direction = :left
      end
      move
    end

    def draw
      @image.draw(x, y, Utility::ZIndex::SPACESHIP)
    end

    def top_left
      [x, y]
    end

    def bottom_right
      [x + WIDTH, y + HEIGHT]
    end

    private

    def move
      @x = if direction == :left
        [x - Utility::SPACESHIP_SPEED, 0].max
      else
        [x + Utility::SPACESHIP_SPEED, MissileCommand::WINDOW_WIDTH].min
      end
    end
  end
end