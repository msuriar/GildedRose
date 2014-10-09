require './gilded_rose.rb'
require "rspec"

describe GildedRose do

  it "should do something after one update" do
    expected = []
    expected << UsefulItem.new("+5 Dexterity Vest", 9, 19)
    expected << UsefulItem.new("Aged Brie", 1, 1)
    expected << UsefulItem.new("Elixir of the Mongoose", 4, 6)
    expected << UsefulItem.new("Sulfuras, Hand of Ragnaros", 0, 80)
    expected << UsefulItem.new("Backstage passes to a TAFKAL80ETC concert", 14, 21)
    expected << UsefulItem.new("Conjured Mana Cake", 2, 5)
    subject.update_quality
    subject.items.should eq expected
  end

  it "should be able to compare items" do
    foo = UsefulItem.new("+5 Dexterity Vest", 10, 20)
    bar = UsefulItem.new("+5 Dexterity Vest", 10, 20)
    foo.should eq bar
  end

  it "should be able to compare lists" do
    foo = [UsefulItem.new("+5 Dexterity Vest", 10, 20)]
    bar = [UsefulItem.new("+5 Dexterity Vest", 10, 20)]
    foo.should eq bar
  end

  it "should be checking item list contents" do
    foo = [UsefulItem.new("+5 Dexterity Vest", 10, 39)]
    bar = [UsefulItem.new("+5 Dexterity Vest", 10, 20)]
    foo.should_not eq bar
  end
end
