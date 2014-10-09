require './gilded_rose.rb'
require "rspec"

describe GildedRose do

  it "should do something after one update" do
    expected = []
    expected << Item.new("+5 Dexterity Vest", 9, 19)
    expected << Item.new("Aged Brie", 1, 1)
    expected << Item.new("Elixir of the Mongoose", 4, 6)
    expected << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    expected << Item.new("Backstage passes to a TAFKAL80ETC concert", 14, 21)
    expected << Item.new("Conjured Mana Cake", 2, 5)
    subject.update_quality
    subject.items.should eq expected
  end

  it "should be able to compare items" do
    foo = Item.new("+5 Dexterity Vest", 10, 20)
    bar = Item.new("+5 Dexterity Vest", 10, 20)
    foo.should eq bar
  end

  it "should be able to compare lists" do
    foo = [Item.new("+5 Dexterity Vest", 10, 20)]
    bar = [Item.new("+5 Dexterity Vest", 10, 20)]
    foo.should eq bar
  end

  it "should be checking item list contents" do
    foo = [Item.new("+5 Dexterity Vest", 10, 39)]
    bar = [Item.new("+5 Dexterity Vest", 10, 20)]
    foo.should_not eq bar
  end

  it "should increase the quality of Brie" do
    foo = Item.new("Aged Brie", 2, 35)
    bar = foo.tick
    bar.quality.should eq 36
  end

  it "should decrease the sell_in of Brie" do
    foo = Item.new("Aged Brie", 12, 0)
    bar = foo.tick
    bar.sell_in.should eq 11
  end

  it "should stop at Brie quality 50" do
    foo = Item.new("Aged Brie", -3, 50)
    bar = foo.tick
    bar.quality.should eq 50
  end

  it "should increase Brie quality by 2 after sell by date" do
    foo = Item.new("Aged Brie", -3, 25)
    foo.tick.quality.should eq 27
  end

  it "should increase Brie quality by 2 after sell by date and stop at 50" do
    foo = Item.new("Aged Brie", -3, 49)
    foo.tick.quality.should eq 50
  end

  it "should never modify Sulfuras" do
    foo = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    foo.tick.should eq foo
  end

  it "should increase ticket quality" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    foo.tick.quality.should eq 21
  end

  it "should not increase ticket quality past 50" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)
    foo.tick.quality.should eq 50
  end

  it "should doubly increase ticket quality with 10 days to go" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)
    foo.tick.quality.should eq 22
  end

  it "should doubly increase ticket quality with 6 days to go" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 20)
    foo.tick.quality.should eq 22
  end

  it "should trebly increase ticket quality with 5 days to go" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)
    foo.tick.quality.should eq 23
  end

  it "should trebly increase ticket quality with 1 day to go" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 20)
    foo.tick.quality.should eq 23
  end

  it "should zero ticket quality with 0 days to go" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)
    foo.tick.quality.should eq 0
  end

  it "should keep ticket quality at zero after the concert" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", -2, 0)
    foo.tick.quality.should eq 0
  end

  it "should decrement ticket sell_in after concert" do
    foo = Item.new("Backstage passes to a TAFKAL80ETC concert", -2, 20)
    bar = foo.tick
    bar.sell_in.should eq (-3)
  end

  it "should decrement normal items by 1 while they are in date" do
    foo = Item.new("+5 Dexterity Vest", 10, 20)
    foo.tick.quality.should eq 19
  end

  it "should decrement sell_in after it's negative" do
    foo = Item.new("+5 Dexterity Vest", -1, 20)
    foo.tick.sell_in.should eq (-2)
  end

  it "should decrement quality at double rate after sell_in is negative" do
    foo = Item.new("Elixir of the Mongoose", -1, 20)
    foo.tick.quality.should eq 18
  end

  it "should keep 0 quality items at 0" do
    foo = Item.new("Elixir of the Mongoose", 3, 0)
    foo.tick.quality.should eq 0
  end

  it "should not decrement quality below 0" do
    foo = Item.new("My Hat", -3, 1)
    foo.tick.quality.should eq 0
  end
end
