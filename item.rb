class Item

  attr_accessor :name, :sell_in, :quality

  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end


end

class UsefulItem < Item

  def ==(i)
    self.name == i.name && self.sell_in == i.sell_in && self.quality == i.quality
  end

  def update_brie
    return BrieItem.new(@name, @sell_in, @quality).update
  end

  def update_sulfuras
    return SulfurasItem.new(@name, @sell_in, @quality).update
  end

  def update_passes
    return ConcertItem.new(@name, @sell_in, @quality).update
  end

  def update
    return NormalItem.new(@name, @sell_in, @quality).update
  end

  def tick
    case @name
    when "Aged Brie"
      return update_brie
    when "Sulfuras, Hand of Ragnaros"
      return update_sulfuras
    when "Backstage passes to a TAFKAL80ETC concert"
      return update_passes
    else
      return update
    end
  end
end

class NormalItem < UsefulItem
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

class BrieItem < UsefulItem
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

class ConcertItem < UsefulItem
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

class SulfurasItem < UsefulItem
  def update
    return self
  end
end
