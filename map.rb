class Map
  CHIP_SIZE = 50
  def initialize(map_data_path)
    @map_data = []
    File.open(map_data_path) do |f|
      f.each do |line|
        @map_data << line.chomp.split(/\s*,\s*/)
      end
    end
    @block_img = Image.load("images/blue.png")
    @bonus_img = Image.load("images/green.png")
    @goal_img = Image.load("images/red.png")
    @white_img = Image.load("images/white.jpg")
  end

  def updata_cell(x,y,num)
    @map_data[y][x] = num
  end

  def update
  end

  #追加しました
  def updata_map_data(x,y,color)
    @map_data[y][x] = color.to_i
  end
  #ここまで　北村

  def draw
    @map_data.each_with_index do |line, my|
      line.each_with_index do |chip_num, mx|
        case chip_num.to_i
        when 2
          Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @block_img)
        when 3
          Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @bonus_img)
        when 5
          Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @goal_img)
        when 6
          Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @white_img)
        end
      end
    end
  end

  # 指定されたマップ座標[new_x, new_y]が進入可能かどうかを真偽値で返す。
  def is_available?(new_x, new_y)
    if @map_data[new_y]
      return @map_data[new_y][new_x].to_i != 2
    end
    return false
  end
end