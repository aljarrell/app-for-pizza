def price(items, arr)
  total = 0
  address = 0
  arr.each do |ingredients|
    if ingredients == "small"
      total += 2
    elsif ingredients == "medium"
      total += 4
    elsif ingredients == "large"
      total += 6
    elsif ingredients == "xlarge"
      total += 8
    elsif ingredients == "no meat"
      total -= 1
    elsif ingredients == "no veggies"
      total -= 1
    end
  end
  total += items += address
  return total
end
