def size()
  size = ["small", "medium", "large", "extra large"]
end

def crust_type()
  crust = ["regular", "thin", "deep dish"]
end

def meats()
  topping = ["bacon", "sausage", "ham", "anchovies", "no meat"]
end

def veggies()
  cheese = ["onions", "peppers", "banana peppers", "tomatoes", "olives"]
end

def sauce()
  sauce = ["marinara", "white", "barbecue sauce"]
end

def pizza(size, topping, cheese, sauce)
  puts "You ordered a #{size} pizza, with #{topping}, #{cheese} cheese, and #{sauce} on the side."
end
