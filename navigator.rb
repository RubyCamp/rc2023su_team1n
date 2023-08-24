class Navigator < Character
  def update(map)
    dx = 0
    dy = 0

    turntime = 0.67 #実行時間
    turn = 0.1
    # 改造部分
    #「→」キーを押すとDXRuby上のアイコンとEV3がアイコンが右を向く
    if Input.key_push?(K_RIGHT)
      @rot += 9
      @rot = @rot % 360
      @ev3_controller.move_righturn(turn)
    end
    #「←」キーを押すとDXRuby上のアイコンとEV3がアイコンが左を向く
    if Input.key_push?(K_LEFT)
      @rot -= 9
      @rot = @rot % 360
      @ev3_controller.move_lefturn(turn)
    end
    #「↑」キー押すとDXRuby上のアイコンの向いてる向きにEV3とアイコンが前に進む
    if Input.key_push?(K_UP)
      if (0..45).cover?(@rot) || (316..360).cover?(@rot)
        dy = 1
        @ev3_controller.move_forward(turntime)
      elsif (46..90).cover?(@rot) || (91..135).cover?(@rot)
        dx = -1
        @ev3_controller.move_forward(turntime)
      elsif (136..180).cover?(@rot) || (181..225).cover?(@rot)
        dy = -1
        @ev3_controller.move_forward(turntime)
      elsif (226..270).cover?(@rot) || (271..315).cover?(@rot)
        dx = 1
        @ev3_controller.move_forward(turntime)
      end
      #case文を使った場合、挙動に難あり
      # case @rot
      # when 0..45 || 315..360
      #   dy = -1
      #   @ev3_controller.move_forward(turntime)
      # when 90
      #   dx = 1
      #   @ev3_controller.move_forward(turntime)
      # when 180
      #   dy = 1
      #   @ev3_controller.move_forward(turntime)
      # when 270
      #   dx = -1
      #   @ev3_controller.move_forward(turntime)
      # end
    end
     #「↓」キー押すとDXRuby上のアイコンの向いてる向きにEV3とアイコンが後ろに進む
    if Input.key_push?(K_DOWN) 
      if (0..45).cover?(@rot) || (316..359).cover?(@rot)
        dy = -1
        @ev3_controller.move_backward(turntime)
      elsif (46..90).cover?(@rot) || (91..135).cover?(@rot)
        dx = 1
        @ev3_controller.move_backard(turntime)
      elsif (136..180).cover?(@rot) || (181..225).cover?(@rot)
        dy = 1
        @ev3_controller.move_backward(turntime)
      elsif (226..270).cover?(@rot) || (271..315).cover?(@rot)
        dx = -1
        @ev3_controller.move_backward(turntime)
      end
      #case文を使った場合難あり
      # case @rot
      # when 0
      #   dy = 1
      #   @ev3_controller.move_backward(turntime)
      # when 90
      #   dx = -1
      #   @ev3_controller.move_backward(turntime)
      # when 180
      #   dy = -1
      #   @ev3_controller.move_backward(turntime)
      # when 270
      #   dx = 1
      #   @ev3_controller.move_backward(turntime)
    end
    

    update_new_position(map, @x + dx, @y + dy)
    # 追加しました
    # co = @ev3_controller.get_color
    # map.updata_map_data(@x,@y,co)
    # ここまで 北村
    Window.draw_font(600, 100, "COLOR: #{@ev3_controller.get_color}", @font)

    # 追加する部分（色の判定）


    color = @ev3_controller.get_color
    # color = @brick.get_sensor(COLOR_SENSOR, 2)

    case color
    when 0 then puts "色がありません"
    when 1 then puts "黒色"
    when 2 then map.updata_map_data(@x, @y, 2)
    when 3 then map.updata_map_data(@x, @y, 3)
    when 4 then puts "黄色"
    when 5 then map.updata_map_data(@x, @y, 5)
    when 6 then map.updata_map_data(@x, @y, 6)
    when 7 then puts "茶色"
    end
  end
end
