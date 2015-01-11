require './lib/cell'
# Any live cell with fewer than two live neighbours dies,
# as if caused by under-population.
# Any live cell with two or three live neighbours lives on
# to the next generation.
# Any live cell with more than three live neighbours dies,
# as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes
# a live cell, as if by reproduction.
describe Cell do
  context "#alive?" do
    it "defaults to true when initialized" do
      cell = Cell.new(0,0)

      expect(cell.alive?).to eq true
    end

    it "returns false when dead" do
      cell = Cell.new(0,0,false)

      expect(cell.alive?).to eq false
    end
  end

  context "#dead?" do
    it "returns true when dead" do
      cell = Cell.new(0,0,false)

      expect(cell.dead?).to eq true
    end

    it "return false when alive" do
      cell = Cell.new(0,0,true)

      expect(cell.dead?).to eq false
    end
  end
end
