class Cell
  attr_reader :x, :y
  attr_accessor :alive

  def initialize(x, y, alive=true)
    @x = x
    @y = y
    @alive = alive
  end

  def alive?
    @alive
  end

  def dead?
    !@alive
  end

end
