module Utility
  def self.left_button?
    Gosu::button_down?(Gosu::KbLeft) || Gosu::button_down?(Gosu::GpLeft)
  end

  def self.right_button?
    Gosu::button_down?(Gosu::KbRight) || Gosu::button_down?(Gosu::GpRight)
  end

  def self.up_button?
    Gosu::button_down?(Gosu::KbUp) || Gosu::button_down?(Gosu::GpUp)
  end

  def self.down_button?
    Gosu::button_down?(Gosu::KbDown) || Gosu::button_down?(Gosu::GpDown)
  end

  def self.a_button?
    Gosu::button_down?(Gosu::KbA)
  end

  def self.s_button?; false; end
  def self.d_button?; false; end

  module ZIndex
    BACKGROUND = 0
    GROUND     = 1
    BUNKER     = 2
    CURSOR     = 3
    BULLET     = 4
    SCORE      = 5
  end

  module Cooldown
    @@cooldown = nil

    def self.on?
      Gosu.milliseconds / 500 == @@cooldown
    end

    def self.set
      @@cooldown = Gosu.milliseconds / 500
    end
  end
end