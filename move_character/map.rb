class Map
  CHIP_SIZE = 32
  BLOCK_CHIP_BLUE = 2
  BLOCK_CHIP_GREEN = 3
  BLOCK_CHIP_RED = 5
  BLOCK_CHIP_WHITE = 6

  def initialize(map_data_path)
    @map_data = []
    File.open(map_data_path) do |f|
      f.each do |line|
        @map_data << line.chomp.split(/\s*,\s*/)
      end
    end
    @blue_block_img = Image.load("images/blue_block.png")
    @green_block_img = Image.load("images/green_block.png")
    @red_block_img = Image.load("images/red_block.png")
    @white_block_img = Image.load("images/white_block.png")

  case 
  end

  def update
  end

  def draw
    @map_data.each_with_index do |line, my|
      line.each_with_index do |chip_num, mx|
        case chip_num.to_i
        when BLOCK_CHIP_BLUE
          Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @blue_block_img)
        when BLOCK_CHIP_GREEN
          Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @green_block_img)
        when BLOCK_CHIP_RED
          Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @red_block_img)
        when BLOCK_CHIP_WHITE
          Window.draw(mx * CHIP_SIZE, my * CHIP_SIZE, @white_block_img)
        end
      end
    end
  end

  # 指定されたマップ座標[new_x, new_y]が進入可能かどうかを真偽値で返す。
  def is_available?(new_x, new_y)
    if @map_data[new_y]
      return @map_data[new_y][new_x].to_i != BLOCK_CHIP_NUM
    end
    return false
  end
end