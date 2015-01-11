# Any live cell with fewer than two live neighbours dies,
# as if caused by under-population.
# Any live cell with two or three live neighbours lives on
# to the next generation.
# Any live cell with more than three live neighbours dies,
# as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes
# a live cell, as if by reproduction.
require 'pry'
class World

  NEIGHBOR_OFFSETS = [
    [-1,-1],[-1,0],[-1,1],
    [0,-1],[0,1],
    [1,-1],[1,0],[1,1]
  ]

  attr_reader :grid_size

  def initialize(grid_size, living_cells)
    @grid_size = grid_size
    @living_cells = living_cells
    @new_generation = []
  end

  def living_cells
    @living_cells.dup
  end

  def next_generation
    (0...grid_size).each do |x|
      (0...grid_size).each do |y|
        cell = find_or_generate_cell(x,y)

        # if fewerThan2Neighbors?(cell) || ... || ..
        #   killCell(cell)
        # else
        #   resurectIt
        # end

        if fewer_than_two_neighbors?(cell)
          cell_dies!(cell)
        end

        if fewer_than_two_or_three_neighbors?(cell)
          cell_lives!(cell)
        end

        if more_than_three_neighbors?(cell)
          cell_dies!(cell)
        end

        if exactly_three_neighbors?(cell)
          cell_lives!(cell)
        end

      end
    end

    @living_cells = @new_generation
  end

private

  def find_or_generate_cell(x,y)
    return Cell.new(x,y,false) unless find_cell(x,y)

    find_cell(x,y)
  end

  def find_cell(x,y)
    @living_cells.find do |cell|
      cell.x == x && cell.y == y
    end
  end

  def num_of_neighbors(cell)
    num_neighbors = 0

    NEIGHBOR_OFFSETS.each do |offset|
      neighbor_cell = Cell.new(cell.x + offset[0], cell.y + offset[1])
      if neighbor_cell.x >= 0 && neighbor_cell.y >= 0
        num_neighbors += 1 if is_living_neighbor(cell, neighbor_cell)
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

  def fewer_than_two_neighbors?(cell)
    cell.alive? && num_of_neighbors(cell) < 2
  end

  def fewer_than_two_or_three_neighbors?(cell)
    cell.alive? && num_of_neighbors(cell) >= 2
  end

  def more_than_three_neighbors?(cell)
    cell.alive? && num_of_neighbors(cell) > 3
  end

  def exactly_three_neighbors?(cell)
    cell.dead? && num_of_neighbors(cell) == 3
  end

  def cell_dies!(cell)
    @new_generation -= [cell]
  end

  def cell_lives!(cell)
    @new_generation << cell
  end
end
