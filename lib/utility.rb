module Utility

  FIRING_RATE = 500 # Lower equals higher firing rate
  BULLET_SPEED = 5  # If this gets too high and bullets don't arrive, increase BULLET_PROXIMITY
  BULLET_PROXIMITY = 2
  CURSOR_SPEED = 2
  EXPLOSION_SPEED = 2

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
    EXPLOSION  = 3
    CURSOR     = 4
    BULLET     = 5
    SCORE      = 6
  end

  # Used to regulate firing rate
  module Cooldown
    @@cooldown = nil

    def self.on?
      Gosu.milliseconds / FIRING_RATE == @@cooldown
    end

    def self.set
      @@cooldown = Gosu.milliseconds / FIRING_RATE
    end
  end
end