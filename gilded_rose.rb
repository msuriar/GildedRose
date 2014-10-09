require './item.rb'

class GildedRose

  attr_accessor :items
  @items = []

  def initialize
    @items = []
    @items << UsefulItem.new("+5 Dexterity Vest", 10, 20)
    @items << UsefulItem.new("Aged Brie", 2, 0)
    @items << UsefulItem.new("Elixir of the Mongoose", 5, 7)
    @items << UsefulItem.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << UsefulItem.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << UsefulItem.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality

    for i in 0..(@items.size-1)
      @items[i].update
    end
  end

end
