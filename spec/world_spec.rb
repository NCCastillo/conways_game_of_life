require './lib/world'
require './lib/cell'
require 'pry'
# Any live cell with fewer than two live neighbours dies,
# as if caused by under-population.
# Any live cell with two or three live neighbours lives on
# to the next generation.
# Any live cell with more than three live neighbours dies,
# as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes
# a live cell, as if by reproduction.

describe World do

  it "tells us what and where the living cells are" do
    cell = Cell.new(0,0)
    world = World.new(1, [cell])

    expect(world.living_cells.length).to eq(1)
    expect(world.living_cells).to include(cell)
  end

  context "with a living cell that has fewer than two live neighbours" do
    it "the cell dies" do
      world = World.new(2, [Cell.new(0,0), Cell.new(1,0)])

      world.next_generation

      expect(world.living_cells.length).to eq(0)
    end
  end

  context "with a living cell that has two or three live neighbours" do
    it "the cell lives" do
      world = World.new(2, [Cell.new(0,0), Cell.new(1,0), Cell.new(0,1), Cell.new(1,1)])

      world.next_generation

      expect(world.living_cells.length).to eq(4)
    end
  end

  context "with a living cell that has more than three live neighbours" do
    it "the cell dies" do
      world = World.new(3, [Cell.new(0,0), Cell.new(1,0), Cell.new(2,0), Cell.new(0,1), Cell.new(2,1)])

      world.next_generation

      expect(world.living_cells.length).to eq(4)
    end
  end

  context "with a dead cell with three live neighbours" do
    it "the cell lives" do
      world = World.new(3, [Cell.new(0,0), Cell.new(0,1), Cell.new(1,1)])

      world.next_generation

      expect(world.living_cells.length).to eq(4)
    end
  end
end

