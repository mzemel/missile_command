require 'gosu'
require 'pry'
require_relative './lib/loader'

class MissileCommand < Gosu::Window
  attr_reader :cursor

  WINDOW_HEIGHT = 400
  WINDOW_WIDTH  = 400

  def initialize
    super WINDOW_HEIGHT, WINDOW_WIDTH
    self.caption = "Missile Command"

    @background_image  = BackgroundImage.new
    @cursor            = Cursor.new
    @bunkers    = [Bunker.new(game: self, key: 'a')]
    @bullets    = []
    @explosions = []
    @enemies    = [
      Enemy::Spaceship.new(
        x: 0,
        y: 20
      ),
      Enemy::Spaceship.new(
        x: 0,
        y: 40
      ),
      Enemy::Spaceship.new(
        x: 0,
        y: 60
      ),
      Enemy::Spaceship.new(
        x: 50,
        y: 20
      ),
    ]
  end

  def update
    [
      @cursor
    ].each(&:update)
    @bunkers.each(&:update)
    @bullets.each(&:update)
    @explosions.each(&:update)
    @enemies.each(&:update)

    handle_collisions
  end

  def draw
    [
      @background_image,
      @cursor
    ].each(&:draw)
    @bunkers.each(&:draw)
    @bullets.each(&:draw)
    @explosions.each(&:draw)
    @enemies.each(&:draw)
    Score.draw
  end

  def register_bullet(bullet)
    @bullets << bullet
  end

  def remove_bullet(bullet)
    @bullets = @bullets.reject { |b| b == bullet }
  end

  def register_explosion(x:, y:)
    @explosions << Explosion.new(x: x, y: y, game: self)
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

  private

  def handle_collisions
    return if @enemies.empty? || @explosions.empty?
    @enemies.product(@explosions).select {|pair| Collision.detect(*pair)}.each do |spaceship, _|
      remove_spaceship(spaceship)
      Score.increase
    end
  end
end

window = MissileCommand.new
window.show