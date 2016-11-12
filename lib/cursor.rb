class Cursor
  attr_reader :cursor, :x, :y

  def initialize
    @cursor = Gosu::Image.new("assets/cursor.png")
    @x = @y = 200
  end

  def update
    move_left  if Utility.left_button?
    move_right if Utility.right_button?
    move_up    if Utility.up_button?
    move_down  if Utility.down_button?
  end

  def draw
    @cursor.draw(x, y, Utility::ZIndex::CURSOR)
  end

  private

  def move_left
    @x = [0, @x - 1].max
  end

  def move_right
    @x = [400, @x + 1].min
  end

  def move_up
    @y = [0, @y - 1].max
  end

  def move_down
    @y = [MissileCommand::WINDOW_HEIGHT - BackgroundImage::GROUND_HEIGHT, @y + 1].min
  end
end