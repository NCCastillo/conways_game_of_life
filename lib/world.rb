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

    (0..grid_size).each do |x|
      (0..grid_size).each do |y|
        cell = find_cell(x,y)
        # binding.pry
        # fewer than 2 then it dies
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

    num_neighbors +=1 if has_upper_left?(cell)
    num_neighbors +=1 if has_upper?(cell)
    num_neighbors +=1 if has_upper_right?(cell)
    num_neighbors +=1 if has_right?(cell)
    num_neighbors +=1 if has_bottom_right?(cell)
    num_neighbors +=1 if has_bottom?(cell)
    num_neighbors +=1 if has_bottom_left?(cell)
    num_neighbors +=1 if has_left?(cell)

    num_neighbors
  end

  def has_upper_left?(cell)
    if cell.x >= 1 || cell.y >= 0
      living_cells.any? do |other_cell|
        other_cell.x == cell.x - 1 &&
        other_cell.y == cell.y + 1
      end
    end
  end

  def has_upper?(cell)
    if cell.x >= 0 || cell.y >= 0
      living_cells.any? do |other_cell|
        other_cell.x == cell.x &&
        other_cell.y == cell.y + 1
      end
    end
  end

  def has_upper_right?(cell)
    if cell.x >= 0 || cell.y >= 0
      living_cells.any? do |other_cell|
        other_cell.x == cell.x + 1 &&
        other_cell.y == cell.y + 1
      end
    end
  end

  def has_right?(cell)
    if cell.x >= 0 || cell.y >= 0
      living_cells.any? do |other_cell|
        other_cell.x == cell.x + 1 &&
        other_cell.y == cell.y
      end
    end
  end

  def has_bottom_right?(cell)
    if cell.x >= 0 || cell.y >= 1
      living_cells.any? do |other_cell|
        other_cell.x == cell.x + 1 &&
        other_cell.y == cell.y - 1
      end
    end
  end

  def has_bottom?(cell)
    if cell.x >= 0 || cell.y >= 1
      living_cells.any? do |other_cell|
        other_cell.x == cell.x &&
        other_cell.y == cell.y - 1
      end
    end
  end

  def has_bottom_left?(cell)
    if cell.x >= 1 || cell.y >= 1
      living_cells.any? do |other_cell|
        other_cell.x == cell.x - 1 &&
        other_cell.y == cell.y - 1
      end
    end
  end

  def has_left?(cell)
    if cell.x >= 1 || cell.y >= 0
      living_cells.any? do |other_cell|
        other_cell.x == cell.x - 1 &&
        other_cell.y == cell.y
      end
    end
  end

end
