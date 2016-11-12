class Collision
  class < self
    def detect(obj1, obj2)
      # +-------+
      # |       |
      # |   2  *-------+
      # |      |       |
      # +------|   1   |
      #        |       |
      #        +-------+
      return true if obj1.top_left[0] <= obj2.bottom_right[0] &&
                      obj1.top_left[0] >= obj2.top_left[0] &&
                      obj1.top_left[1] <= obj2.bottom_right[1] && 
                      obj1.top_left[1] >= obj2.top_left[1]

      # +-------+
      # |       |
      # |   1   |------+
      # |       |      |
      # +-------*  2   |
      #        |       |
      #        +-------+
      return true if obj1.bottom_right[0] >= obj2.top_left[0] &&
                      obj1.bottom_right[0] <= obj2.bottom_right[0] &&
                      obj1.bottom_right[1] >= obj2.top_left[1] &&
                      obj1.bottom_right[1] <= obj2.bottom_right[1]

      #        +-------+
      #        |       |
      # +-------*  2   |
      # |       |      |
      # |   1   |------+
      # |       |
      # +-------+
      return true if obj1.top_left[1] >= obj2.top_left[1] &&
                      obj1.top_left[1] <= obj2.bottom_right[1] &&
                      obj1.bottom_right[0] >= obj2.top_left[0] &&
                      obj1.bottom_right[0] <= obj2.bottom_right[0]

      #        +-------+
      #        |       |
      # +------|   1   |
      # |      |       |
      # |   2  *-------+
      # |       |
      # +-------+
      return true if obj1.top_left[0] >= obj2.top_left[0] &&
                      obj1.top_left[0] <= obj2.bottom_right[0] &&
                      obj1.bottom_right[1] >= obj2.top_left[1] &&
                      obj1.bottom_right[1] <= obj2.bottom_right[1]
    end
  end
end