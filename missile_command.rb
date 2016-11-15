require 'gosu'
require_relative './lib/loader'

class MissileCommand < Gosu::Window
  attr_reader :cursor, :current_level, :levels, :game_over, :background_image
  attr_accessor :difficulty

  HEIGHT = 400
  WIDTH  = 400

  def initialize
    super HEIGHT, WIDTH, fullscreen: true
    self.caption = "Missile Command"

    @background_image  = BackgroundImage.new
    @cursor            = Cursor.new
    @img_game_over     = Gosu::Font.new(20)
    reset!
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
    roll_credits
    if Utility.r_button?
      @game_over = @roll_credits = false
      @levels        = Levels::Collection.new(game: self)
      @current_level = Levels::Intro.new(game: self)
      background_image.set_planet("default")
    end
  end

  def reset!
    @levels            = Levels::Collection.new(game: self)
    @current_level     = Levels::Intro.new(game: self)
    @game_over = @roll_credits = false
  end

  def roll_credits
    return if @roll_credits
    @roll_credits = true
    background_image.set_music(nil)
    clip  = if win?
              %w(force strong ally).sample
            else
              %w(jabba feeble darkside operational).sample
            end
    Gosu::Sample.new("assets/sounds/#{clip}.mp3").play
  end

  def display_game_over(text:)
    @img_game_over.draw(text, 165, 50, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
    @img_game_over.draw("Press [r] to play again", 120, 75, Utility::ZIndex::SCORE, 1.0, 1.0, 0xff_ffff00)
  end
end

window = MissileCommand.new
window.show