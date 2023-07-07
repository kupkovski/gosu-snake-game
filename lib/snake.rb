require 'gosu'
require_relative 'snake_game'

# handles the Snake element
class Snake
  attr_accessor :x, :y, :score

  MIN_TAIL_SIZE = 3

  def initialize
    @x = 10
    @y = 10

    @vel_x = 0
    @vel_y = 0

    @tail = MIN_TAIL_SIZE
    @position = []
    @score = 0
  end

  def update
    @x += @vel_x
    @y += @vel_y
    @position << [@x, @y]
    @position.shift until @position.size <= @tail
  end

  def draw
    @position.each do |x, y|
      Gosu.draw_rect(
        x * SnakeGame::TILE,
        y * SnakeGame::TILE,
        SnakeGame::TILE - 1,
        SnakeGame::TILE - 1,
        Gosu::Color::GREEN
      )
    end
  end

  def increase
    @tail += 1
  end

  def self_colide?
    return false if @position.empty?

    head = @position[0]
    tail = @position[1..]
    tail&.include?(head)
  end

  def touches_borders?
    @x >= SnakeGame::WIDTH_IN_TILE || @y >= SnakeGame::WIDTH_IN_TILE || @x.negative? || @y.negative?
  end

  def up
    return unless @vel_y.zero?

    @vel_x =  0
    @vel_y = -1
  end

  def down
    return unless @vel_y.zero?

    @vel_x =  0
    @vel_y =  1
  end

  def left
    return unless @vel_x.zero?

    @vel_x = -1
    @vel_y =  0
  end

  def right
    return unless @vel_x.zero?

    @vel_x =  1
    @vel_y =  0
  end
end
