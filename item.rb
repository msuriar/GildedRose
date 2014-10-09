class Item

  attr_accessor :name, :sell_in, :quality

  def initialize (name, sell_in, quality)
    @name, @sell_in, @quality = name, sell_in, quality
  end

  def ==(i)
    self.name == i.name && self.sell_in == i.sell_in && self.quality == i.quality
  end

  def tick
    case @name
    when "Aged Brie"
      @item = BrieItem.new(@name, @sell_in, @quality)
      @item.update
    when "Sulfuras, Hand of Ragnaros"
      @item = SulfurasItem.new(@name, @sell_in, @quality)
      @item.update
    when "Backstage passes to a TAFKAL80ETC concert"
      @item = ConcertItem.new(@name, @sell_in, @quality)
      @item.update
    else
      @item = NormalItem.new(@name, @sell_in, @quality)
      @item.update
    end
  end
end

class NormalItem < Item
  def update
    if @sell_in < 0
      new_quality = @quality-2
    else
      new_quality = @quality-1
    end
    limited_quality = [new_quality, 0].max
    return NormalItem.new(@name, @sell_in-1, limited_quality)
  end
end

class BrieItem < Item
  def update
    if @sell_in < 0
      new_quality = @quality+2
    else
      new_quality = @quality+1
    end
    limited_quality = [new_quality, 50].min
    return BrieItem.new(@name, @sell_in-1, limited_quality)
  end
end

class ConcertItem < Item
  def update
    case
    when 10 < @sell_in
      new_quality = @quality+1
    when 5 < @sell_in && @sell_in <= 10
      new_quality = @quality+2
    when 0 < @sell_in && @sell_in <= 5
      new_quality = @quality+3
    else
      new_quality = 0
    end
    limited_quality = [new_quality, 50].min
    return ConcertItem.new(@name, @sell_in-1, limited_quality)
  end
end

class SulfurasItem < Item
  def update
    return self
  end
end
