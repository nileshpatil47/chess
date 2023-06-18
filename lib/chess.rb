class Chess
  DIRECTION = ['WEST', 'NORTH', 'EAST', 'SOUTH']
  X = 0
  Y = 1
  VALID_FIRST_MOVE = [0, 1, 2]
  attr_accessor :chess, :colour, :direction, :current_position, :next_position, :placed

  def initialize(x, y, direction, colour)
    @chess = Array.new(8, 'present'){Array.new(8, 'present')}
    @colour = colour
    @direction = DIRECTION.index(direction) if DIRECTION.include?(direction)
    @current_position = [nil, nil]
    @next_position = [x, y]
    @placed = nil
  end

  def place
    if VALID_FIRST_MOVE.include?(@next_position[Y])
      @current_position = @next_position
      @placed = true
    else
      @next_position = @current_position = [nil, nil]
      @colour = nil
      @direction = nil
      @placed = false
    end
  end

  def report
    str = "#{@current_position[X]}, #{@current_position[Y]}, #{DIRECTION[@direction]}, #{@colour}"
    puts str
    str
  end

  def left
    if @direction.zero?
      @direction = DIRECTION.length - 1
    else
      @direction -= 1
    end
  end

  def right
    if @direction.eql?(DIRECTION.length - 1)
      @direction = 0
    else
      @direction += 1
    end
  end

  def move
    return unless @placed
    if @direction.eql?(0) && @next_position[X] > 0
      @next_position[X] -= 1
    elsif @direction.eql?(1) && @next_position[Y] < 7
      @next_position[Y] += 1
    elsif @direction.eql?(2) && @next_position[X] < 7
      @next_position[X] += 1
    elsif @direction.eql?(3) && @next_position[Y] > 0
      @next_position[Y] -= 1
    end
    @current_position = @next_position
  end
end
