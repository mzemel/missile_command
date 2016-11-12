require 'gosu'
require_relative './lib/loader'

class MissileCommand < Gosu::Window
  attr_reader :cursor

  WINDOW_HEIGHT = 400
  WINDOW_WIDTH  = 400

  def initialize
    super WINDOW_HEIGHT, WINDOW_WIDTH
    self.caption = "Missile Command"

    @background_image = BackgroundImage.new
    @cursor           = Cursor.new
    @bunker           = Bunker.new(game: self)
    @bullets          = []
  end

  def update
    [
      @cursor,
      @bunker
    ].each(&:update)
    @bullets.each(&:update)
  end

  def draw
    [
      @background_image,
      @cursor,
      @bunker
    ].each(&:draw)
    @bullets.each(&:draw)
    Score.draw
  end

  def register_bullet(bullet)
    @bullets << bullet
  end

  def remove_bullet(bullet)
    @bullets = @bullets.reject { |b| b == bullet }
  end
end

window = MissileCommand.new
window.show