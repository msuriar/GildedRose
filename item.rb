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
    ret = UsefulItem.new(name, sell_in, quality)
    if quality < 50
      ret.quality += 1
    end
    ret.sell_in -= 1
    return ret
  end

  def update_sulfuras
    return self
  end

  def update
    case @name
    when "Aged Brie"
      return update_brie
    when "Sulfuras, Hand of Ragnaros"
      return update_sulfuras
    end

    ret = UsefulItem.new(self.name, self.sell_in, self.quality)
    if (ret.name != "Aged Brie" && ret.name != "Backstage passes to a TAFKAL80ETC concert")
      if (ret.quality > 0)
        if (ret.name != "Sulfuras, Hand of Ragnaros")
          ret.quality = ret.quality - 1
        end
      end
    else
      if (ret.quality < 50)
        ret.quality = ret.quality + 1
        if (ret.name == "Backstage passes to a TAFKAL80ETC concert")
          if (ret.sell_in < 11)
            if (ret.quality < 50)
              ret.quality = ret.quality + 1
            end
          end
          if (ret.sell_in < 6)
            if (ret.quality < 50)
              ret.quality = ret.quality + 1
            end
          end
        end
      end
    end
    if (ret.name != "Sulfuras, Hand of Ragnaros")
      ret.sell_in = ret.sell_in - 1;
    end
    if (ret.sell_in < 0)
      if (ret.name != "Aged Brie")
        if (ret.name != "Backstage passes to a TAFKAL80ETC concert")
          if (ret.quality > 0)
            if (ret.name != "Sulfuras, Hand of Ragnaros")
              ret.quality = ret.quality - 1
            end
          end
        else
          ret.quality = ret.quality - ret.quality
        end
      else
        if (ret.quality < 50)
          ret.quality = ret.quality + 1
        end
      end
    end
    ret
  end
end
