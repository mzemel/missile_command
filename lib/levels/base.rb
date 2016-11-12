module Levels
  class Base

    attr_reader :game, :bullets, :explosions, :enemies

    def initialize(game:)
      @game       = game
      @bullets    = []
      @explosions = []
      @bunkers    = []
      @enemies    = []
    end

    def update
      @bunkers.each(&:update)
      @bullets.each(&:update)
      @explosions.each(&:update)
      @enemies.each(&:update)

      handle_collisions
    end

    def draw
      @bunkers.each(&:draw)
      @bullets.each(&:draw)
      @explosions.each(&:draw)
      @enemies.each(&:draw)
    end

    def register_bullet(bullet)
      @bullets << bullet
    end

    def remove_bullet(bullet)
      @bullets = @bullets.reject { |b| b == bullet }
    end

    def register_explosion(x:, y:)
      @explosions << Explosion.new(x: x, y: y, level: self)
    end

    def remove_explosion(explosion)
      @explosions = @explosions.reject { |e| e == explosion }
    end

    def register_spaceship(x:, y:)
      @enemies << Enemy::Spaceship.new(x: x, y: y)
    end

    def remove_spaceship(spaceship)
      @enemies = @enemies.reject { |e| e == spaceship }
    end

    def out_of_ammo?
      @explosions.empty? &&
        @bullets.empty? &&
        @bunkers.select{ |b| b.ammo.empty? }.count == @bunkers.count
    end

    private

    def handle_collisions
      return if @enemies.empty? || @explosions.empty?
      @enemies.product(@explosions).select {|pair| Collision.detect(*pair)}.each do |spaceship, _|
        remove_spaceship(spaceship)
        Score.increase
      end
    end
  end
end