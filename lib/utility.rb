module Utility

  FIRING_RATE = 500 # Lower equals higher firing rate
  PROJECTILE_SPEED = 5  # If this gets too high and bullets don't arrive, increase PROJECTILE_PROXIMITY
  PROJECTILE_PROXIMITY = 2
  CURSOR_SPEED = 4
  CURSOR_BLINK_RATE = 250
  EXPLOSION_SPEED = 2
  SPACESHIP_SPEED = 1
  BUNKER_KEYS = {
    0 => 'a',
    1 => 's',
    2 => 'd',
    3 => 'f',
    4 => 'g',
    5 => 'h'
  }

  FIRE_PROBABILITY = {
    'easy' => 1000,
    'medium' => 800,
    'hard' => 500,
    'insane' => 50
  }

  DEFENDER_HEALTH_TABLE = {
    'low' => 1,
    'medium' => 2,
    'high' => 3
  }

  SPACESHIP_HEALTH_TABLE = {
    'low' => 1,
    'medium' => 20,
    'high' => 50,
    'insane' => 100
  }

  BATTLESHIP_HEALTH_TABLE = {
    'low' => 1,
    'medium' => 20,
    'high' => 50,
    'insane' => 100
  }

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

  def self.e_button?
    Gosu::button_down?(Gosu::KbE)
  end

  def self.m_button?
    Gosu::button_down?(Gosu::KbM)
  end

  def self.h_button?
    Gosu::button_down?(Gosu::KbH)
  end

  def self.r_button?
    Gosu::button_down?(Gosu::KbR)
  end

  # Defines self.<<char>>_button? for all BUNKER_KEYS
  class << self
    Utility::BUNKER_KEYS.each do |_, char|
      define_method("#{char}_button?") do
        Gosu::button_down?(Kernel.const_get("Gosu::Kb#{char.upcase}"))
      end
    end
  end

  module ZIndex
    BACKGROUND = 0
    GROUND     = 1
    SCORE      = 1
    HEALTH_BAR = 1
    BUNKER     = 2
    SPACESHIP  = 2
    DEFENDER   = 2
    EXPLOSION  = 3
    CURSOR     = 4
    PROJECTILE = 5
    DEBUG      = 99
  end

  module Debug
    def self.trace(obj, c = nil)
      c ||= Explosion::COLOR
      # Left
      Gosu.draw_line(*obj.top_left, c, obj.top_left[0], obj.bottom_right[1], c, ZIndex::DEBUG, mode = :default)
      # Top
      Gosu.draw_line(*obj.top_left, c, obj.bottom_right[0], obj.top_left[1], c, ZIndex::DEBUG, mode = :default)
      # Right
      Gosu.draw_line(*obj.bottom_right, c, obj.bottom_right[0], obj.top_left[1], c, ZIndex::DEBUG, mode = :default)
      # Bottom
      Gosu.draw_line(*obj.bottom_right, c, obj.top_left[0], obj.bottom_right[1], c, ZIndex::DEBUG, mode = :default)
    end
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