class Cursor
  attr_reader :cursor, :x, :y

  def initialize
    @cursor_white = Gosu::Image.new("assets/cursor_white.png")
    @cursor_grey = Gosu::Image.new("assets/cursor_grey.png")
    @x = @y = 200
  end

  def update
    move_left  if Utility.left_button?
    move_right if Utility.right_button?
    move_up    if Utility.up_button?
    move_down  if Utility.down_button?
  end

  def draw
    if (Gosu.milliseconds / Utility::CURSOR_BLINK_RATE).odd?
      @cursor_white.draw(x, y, Utility::ZIndex::CURSOR)
    else
      @cursor_grey.draw(x, y, Utility::ZIndex::CURSOR)
    end
  end

  private

  def move_left
    @x = [0, @x - Utility::CURSOR_SPEED].max
  end

  def move_right
    @x = [400, @x + Utility::CURSOR_SPEED].min
  end

  def move_up
    @y = [0, @y - Utility::CURSOR_SPEED].max
  end

  def move_down
    @y = [MissileCommand::HEIGHT - BackgroundImage::GROUND_HEIGHT, @y + Utility::CURSOR_SPEED].min
  end
end