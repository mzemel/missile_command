require 'gosu'
require_relative './lib/loader'

class MissileCommand < Gosu::Window
  WINDOW_HEIGHT = 400
  WINDOW_WIDTH  = 400

  def initialize
    super WINDOW_HEIGHT, WINDOW_WIDTH
    self.caption = "Missile Command"

    @background_image = BackgroundImage.new
    @cursor           = Cursor.new
    @bunker           = Bunker.new
  end

  def update
    [
      @cursor,
      @bunker
    ].each(&:update)
  end

  def draw
    [
      @background_image,
      @cursor,
      @bunker
    ].each(&:draw)
  end
end

window = MissileCommand.new
window.show