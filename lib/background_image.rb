class BackgroundImage
  attr_reader :background_image, :ground

  GROUND_HEIGHT = 70

  def initialize
    @background_image = Gosu::Image.new("assets/background.png")
    @ground           = Gosu::Image.new("assets/ground.png")
  end

  def draw
    background_image.draw(0,0,Utility::ZIndex::BACKGROUND)
    ground.draw(0, MissileCommand::HEIGHT - GROUND_HEIGHT, Utility::ZIndex::GROUND)
  end
end