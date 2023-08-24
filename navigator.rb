class Navigator < Character
  def update(map)
    dx = 0
    dy = 0

    turntime = 0.7 #実行時間
    # 改造部分
    #「→」キーを押すとDXRuby上のアイコンとEV3がアイコンが右を向く
    if Input.key_push?(K_RIGHT)
      @rot += 90
      @rot = @rot % 360
      @ev3_controller.move_righturn(turntime)
    end
    #「←」キーを押すとDXRuby上のアイコンとEV3がアイコンが左を向く
    if Input.key_push?(K_LEFT)
      @rot -= 90
      @rot = @rot % 360
      @ev3_controller.move_lefturn(turntime)
    end
    #「↑」キー押すとDXRuby上のアイコンの向いてる向きにEV3とアイコンが前に進む
    if Input.key_push?(K_UP)
      case @rot
      when 0
        dy = -1
        @ev3_controller.move_forward(turntime)
      when 90
        dx = 1
        @ev3_controller.move_forward(turntime)
      when 180
        dy = 1
        @ev3_controller.move_forward(turntime)
      when 270
        dx = -1
        @ev3_controller.move_forward(turntime)
      end
    end
    #「↓」キー押すとDXRuby上のアイコンの向いてる向きにEV3とアイコンが後ろに進む
    if Input.key_push?(K_DOWN)
      case @rot
      when 0
        dy = 1
        @ev3_controller.move_backward(turntime)
      when 90
        dx = -1
        @ev3_controller.move_backward(turntime)
      when 180
        dy = -1
        @ev3_controller.move_backward(turntime)
      when 270
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
