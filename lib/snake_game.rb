require 'gosu'
require_relative 'snake'
require_relative 'fruit'

class SnakeGame < Gosu::Window
  WIDTH  = 400
  HEIGHT = 400
  TILE   = 10

  WIDTH_IN_TILE = WIDTH / TILE

  def initialize
    super WIDTH, HEIGHT, false, 1000 / 15

    @snake = Snake.new
    @fruit = Fruit.new
    @font = Gosu::Font.new(20)
    begin
      @max_score = File.read('/home/andre/snake-game-ruby/score.txt')
    rescue Errno::ENOENT
      @max_score = '0'
    end
  end

  def update
    if eat_fruit?
      @fruit.regenerate
      @snake.increase
      @snake.score += 1
    end

    reset_game if @snake.self_colide?

    @snake.update
  end

  def draw
    @snake.draw
    @fruit.draw
    @font.draw_text("Max Score: #{@max_score}", 10, 10, 0, 1.0, 1.0, Gosu::Color::RED)
    @font.draw_text("Current Score: #{@snake.score}", 10, 30, 0, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(id)
    case id
    when Gosu::KbUp     then @snake.up
    when Gosu::KbDown   then @snake.down
    when Gosu::KbLeft   then @snake.left
    when Gosu::KbRight  then @snake.right
    when Gosu::KbEscape then exit
    end
  end

  private

  def eat_fruit?
    @snake.x == @fruit.x && @snake.y == @fruit.y
  end

  def reset_game
    write_max_score

    @snake = Snake.new
    @fruit = Fruit.new
  end
  
  def write_max_score
    return if @snake.score.zero?
    @max_score = @snake.score
    File.write('/home/andre/snake-game-ruby/score.txt', @snake.score)
  end
end
