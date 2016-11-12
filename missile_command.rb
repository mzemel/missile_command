require 'gosu'
require 'pry'
require_relative './lib/loader'

class MissileCommand < Gosu::Window
  attr_reader :cursor

  HEIGHT = 400
  WIDTH  = 400

  def initialize
    super HEIGHT, WIDTH
    self.caption = "Missile Command"

    @background_image  = BackgroundImage.new
    @cursor            = Cursor.new
    @levels            = Levels::Collection.new(game: self)
    @level             = @levels.shift
    @img_game_over     = Gosu::Font.new(20)
    @game_over         = false
  end

  def update
    return if @game_over
    @cursor.update
    @level.update
    check_game_over
    @level = @levels.shift if !@game_over && level_over?
  end

  def draw
    if @game_over && win?
      @img_game_over.draw("You win!", 200, 50, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
    elsif @game_over
      @img_game_over.draw("Game over", 200, 50, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
    else
      @cursor.draw
      @level.draw
    end
    @background_image.draw
    Score.draw
  end

  private

  def level_over?
    @level.enemies.count == 0
  end

  def win?
    level_over? && @levels.empty?
  end

  def lose?
    @level.out_of_ammo? && @level.enemies.count != 0
  end

  def check_game_over
    if win? || lose?
      @game_over = true
    end
  end
end

window = MissileCommand.new
window.show