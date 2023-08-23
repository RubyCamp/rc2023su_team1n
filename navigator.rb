class Navigator < Character
  def update(map)
    dx = 0
    dy = 0

    turntime = 0.8 #実行時間
    # 改造部分
    if Input.key_push?(K_RIGHT)
      @rot += 90
      @rot = @rot % 360
      puts @rot
      @ev3_controller.move_righturn(turntime)
    end

    if Input.key_push?(K_LEFT)
      @rot -= 90
      @rot = @rot % 360
      puts @rot
      @ev3_controller.move_lefturn(turntime)
    end

    if Input.key_push?(K_UP)
      if @rot == 0
        dy = -1
        puts @rot
        @ev3_controller.move_forward(turntime)
      elsif @rot == 90
        dx = 1
        puts @rot
        @ev3_controller.move_forward(turntime)
      elsif @rot == 180
        dy = 1
        puts @rot
        @ev3_controller.move_forward(turntime)
      elsif @rot == 270
        dx = -1
        puts @rot
        @ev3_controller.move_forward(turntime)
      end
    end

    if Input.key_push?(K_DOWN)
      if @rot == 0
        dy = 1
        @ev3_controller.move_backward(turntime)
      elsif @rot == 90
        dx = -1
        @ev3_controller.move_backward(turntime)
      elsif @rot == 180
        dy = -1
        @ev3_controller.move_backward(turntime)
      elsif @rot == 270
        dx = 1
        @ev3_controller.move_backward(turntime)
      end
    end
    # ここまで

    update_new_position(map, @x + dx, @y + dy)
    # 追加しました
    co = @ev3_controller.get_color
    map.updata_map_data(@x,@y,co)
    # ここまで 北村
    Window.draw_font(600, 100, "COLOR: #{@ev3_controller.get_color}", @font)
  end
end
