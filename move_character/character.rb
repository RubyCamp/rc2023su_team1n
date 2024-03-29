class Character
  def initialize(x, y, img)
    @x = x
    @y = y
    @rot = 0
    @img = img
  end

  def update(map)
  end

  def draw
    Window.draw_rot(@x * Map::CHIP_SIZE, @y * Map::CHIP_SIZE, @img,@rot) # 移動単位をピクセル単位からマップ座標系の単位に変更
  end

  def close
    @ev3_controller.close
  end

  private

  # 次のフレームで位置すべきマップ上の座標が進入可能であれば移動し、そうでなければ現在位置に留まる
  def update_new_position(map, new_x, new_y)
    if map.is_available?(new_x, new_y)
      @x, @y = new_x, new_y
    end
  end
end