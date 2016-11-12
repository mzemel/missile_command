require 'gosu'
require_relative './lib/loader'

class MissileCommand < Gosu::Window
  def initialize
    super 400, 400
    self.caption = "Missile Command"

    @background_image = BackgroundImage.new
    @cursor           = Cursor.new
  end

  def update
    [
      @cursor
    ].each(&:update)
  end

  def draw
    [
      @background_image,
      @cursor
    ].each(&:draw)
  end
end

window = MissileCommand.new
window.show