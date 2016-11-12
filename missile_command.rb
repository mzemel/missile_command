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
    @bunker            = Bunker.new(game: self)
    @bullets    = []
    @explosions = []
  end

  def update
    [
      @cursor,
      @bunker
    ].each(&:update)
    @bullets.each(&:update)
    @explosions.each(&:update)
  end

  def draw
    [
      @background_image,
      @cursor,
      @bunker
    ].each(&:draw)
    @bullets.each(&:draw)
    @explosions.each(&:draw)
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
end

window = MissileCommand.new
window.show