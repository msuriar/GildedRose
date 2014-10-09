require './gilded_rose.rb'
require "rspec"

describe GildedRose do

  it "should do something" do
    subject.update_quality
  end

  it "should be able to compare items" do
    foo = UsefulItem.new("+5 Dexterity Vest", 10, 20)
    bar = UsefulItem.new("+5 Dexterity Vest", 10, 20)

    foo.should eq bar
  end
end
