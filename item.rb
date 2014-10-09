class Item
  attr_reader :name

  def quality
    @item.quality
  end

  def sell_in
    @item.sell_in
  end

  def initialize (name, sell_in, quality)
    @name = name
    @item = klass_for(name).new(sell_in, quality)
  end

  def klass_for(name)
    case name
    when "Aged Brie"
      BrieItem
    when "Sulfuras, Hand of Ragnaros"
      SulfurasItem
    when "Backstage passes to a TAFKAL80ETC concert"
      ConcertItem
    when "Conjured Mana Cake"
      ConjuredItem
    else
      NormalItem
    end
  end

  def ==(i)
    self.name == i.name && self.sell_in == i.sell_in && self.quality == i.quality
  end

  def tick
    @item = @item.update
    return self
  end
end

class BaseItem
  attr_reader :sell_in, :quality
  def initialize(sell_in, quality)
    @sell_in, @quality = sell_in, quality
  end
end

class NormalItem < BaseItem
  def update
    if @sell_in < 0
      new_quality = @quality-2
    else
      new_quality = @quality-1
    end
    limited_quality = [new_quality, 0].max
    return NormalItem.new(@sell_in-1, limited_quality)
  end
end

class BrieItem < BaseItem
  def update
    if @sell_in < 0
      new_quality = @quality+2
    else
      new_quality = @quality+1
    end
    limited_quality = [new_quality, 50].min
    return BrieItem.new(@sell_in-1, limited_quality)
  end
end

class ConcertItem < BaseItem
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
    return ConcertItem.new(@sell_in-1, limited_quality)
  end
end

class SulfurasItem < BaseItem
  def update
    return self
  end
end

class ConjuredItem < BaseItem
  def update
    if @sell_in < 0
      new_quality = @quality-4
    else
      new_quality = @quality-2
    end
    limited_quality = [new_quality, 0].max
    return ConjuredItem.new(@sell_in-1, limited_quality)
  end
end
