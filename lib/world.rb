require 'pry'

class World

  NEIGHBOR_OFFSETS = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]

  attr_reader :grid_size

  def initialize(grid_size, living_cells)
    @grid_size = grid_size
    @living_cells = living_cells
  end

  def living_cells
    @living_cells.dup
  end

  def next_generation
    new_generation = []

    (0...grid_size).each do |x|
      (0...grid_size).each do |y|
        is_living_cell = has_living_cell?(x, y)
        neighbor_count = num_of_neighbors(x, y)

        if (is_living_cell && neighbor_count.between?(2,3)) ||
          (!is_living_cell && neighbor_count == 3)
          new_generation << Cell.new(x,y)
        end

      end
    end

    @living_cells = new_generation
  end

private

  def has_living_cell?(x,y)
    @living_cells.find do |cell|
      cell.x == x && cell.y == y
    end
  end

  def num_of_neighbors(x,y)
    num_neighbors = 0

    NEIGHBOR_OFFSETS.each do |offset|
      neighbor_cell = Cell.new(x + offset[0], y + offset[1])
      if neighbor_cell.x >= 0 && neighbor_cell.y >= 0
        num_neighbors += 1 if is_living_neighbor(Cell.new(x,y), neighbor_cell)
      end
    end

    num_neighbors
  end

  def is_living_neighbor(cell, neighbor_cell)
    living_cells.any? do |other_cell|
      other_cell.x == neighbor_cell.x &&
      other_cell.y == neighbor_cell.y
    end
  end

end
