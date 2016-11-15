require 'gosu'
require 'pry'
require_relative './lib/loader'

class MissileCommand < Gosu::Window
  attr_reader :cursor, :current_level, :levels, :game_over, :background_image
  attr_accessor :difficulty

  HEIGHT = 400
  WIDTH  = 400

  def initialize
    super HEIGHT, WIDTH
    self.caption = "Missile Command"

    @background_image  = BackgroundImage.new
    @cursor            = Cursor.new
    @levels            = Levels::Collection.new(game: self)
    @current_level     = Levels::Intro.new(game: self)
    @img_game_over     = Gosu::Font.new(20)
    @game_over         = false
  end

  def update
    handle_game_over if game_over
    cursor.update
    current_level.update
    check_game_over
    if !game_over && current_level.over?
      current_level.apply_bonuses
      @current_level = levels.shift 
    end
  end

  def draw
    if game_over && win?
      Score.check_high_score
      display_game_over(text: "You win!")
    elsif game_over
      Score.check_high_score
      display_game_over(text: "Game over!")
      current_level.bunkers.each(&:draw)
    else
      cursor.draw
      current_level.draw
    end
    @background_image.draw
    Score.draw
  end

  private

  def win?
    current_level.over? && levels.empty?
  end

  def lose?
    !current_level.over? && current_level.out_of_ammo?
  end

  def check_game_over
    if win? || lose?
      @game_over = true
    end
  end

  def handle_game_over
    if Utility.r_button?
      @game_over     = false
      @levels        = Levels::Collection.new(game: self)
      @current_level = Levels::Intro.new(game: self)
    end
  end

  def display_game_over(text:)
    @img_game_over.draw(text, 165, 50, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
    @img_game_over.draw("Press [r] to play again", 120, 75, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
  end
end

window = MissileCommand.new
window.show