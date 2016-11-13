module Utility

  FIRING_RATE = 500 # Lower equals higher firing rate
  PROJECTILE_SPEED = 5  # If this gets too high and bullets don't arrive, increase BULLET_PROXIMITY
  PROJECTILE_PROXIMITY = 2
  CURSOR_SPEED = 4
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
  SPACESHIP_FIRE_PROBABILITY = {
    'easy' => 1000,
    'medium' => 800,
    'hard' => 500,
    'insane' => 50
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

  def self.a_button?
    Gosu::button_down?(Gosu::KbA)
  end

  def self.space_button?
    Gosu::button_down?(Gosu::KbSpace)
  end

  def self.s_button?; false; end
  def self.d_button?; false; end

  module ZIndex
    BACKGROUND = 0
    GROUND     = 1
    BUNKER     = 2
    SPACESHIP  = 2
    EXPLOSION  = 3
    CURSOR     = 4
    PROJECTILE = 5
    SCORE      = 6
  end

  module Debug
    def self.trace(obj, color = nil)
      c ||= Explosion::COLOR
      # Left
      Gosu.draw_line(*obj.top_left, c, obj.top_left[0], obj.bottom_right[1], c, z = 99, mode = :default)
      # Top
      Gosu.draw_line(*obj.top_left, c, obj.bottom_right[0], obj.top_left[1], c, z = 99, mode = :default)
      # Right
      Gosu.draw_line(*obj.bottom_right, c, obj.bottom_right[0], obj.top_left[1], c, z = 99, mode = :default)
      # Bottom
      Gosu.draw_line(*obj.bottom_right, c, obj.top_left[0], obj.bottom_right[1], c, z = 99, mode = :default)
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