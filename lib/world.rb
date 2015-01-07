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
        cell = find_cell(x,y)

        # if fewerThan2Neighbors?(cell) || ... || ..
        #   killCell(cell)
        # else
        #   resurectIt
        # end
        if cell && num_of_neighbors?(cell) < 2
          new_generation -= [cell]
        end

        # 2 or 3 lives
        if cell && num_of_neighbors?(cell) >= 2
          new_generation << cell
        end

        # more than 3 then it dies
        if cell && num_of_neighbors?(cell) > 3
          new_generation -= [cell]
        end

        # exactly 3 then lives
        # cell is nil since it doesn't exist therefore it is dead.
        if !cell && num_of_neighbors?(Cell.new(x, y)) == 3
          new_generation << Cell.new(x, y)
        end
      end
    end

    @living_cells = new_generation
  end

private

  def find_cell(x,y)
    @living_cells.find do |cell|
      cell.x == x && cell.y == y
    end
  end

  def num_of_neighbors?(cell)
    num_neighbors = 0

    neighborOffsets = [
      [-1,-1],[-1,0],[-1,1],
      [0,-1],[0,1],
      [1,-1],[1,0],[1,1]].each do |offset|
        neighborCell = Cell.new(cell.x + offset[0], cell.y + offset[1])
        if( neighborCell.x >= 0 && neighborCell.y >= 0)
          num_neighbors += 1 if isLivingNeighbor?(cell, neighborCell)
        end
      end

    num_neighbors
  end

  def isLivingNeighbor?(cell, neighborCell)
    living_cells.any? do |other_cell|
      other_cell.x == neighborCell.x &&
      other_cell.y == neighborCell.y
    end
  end

end
