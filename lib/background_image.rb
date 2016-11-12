class BackgroundImage
  attr_reader :background_image

  def initialize
    @background_image = Gosu::Image.new("assets/dirtCenter.png", tileable: true)
  end

  def draw
    background_image.draw(0,0,0)
  end
end