class Item

  attr_accessor :name, :sell_in, :quality
        
  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end


end

class UsefulItem < Item

  def ==(another_item)
    self.name == another_item.name\
    && self.sell_in == another_item.sell_in\
    && self.quality == another_item.quality
  end
end
