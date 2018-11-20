def size()
  size = ["small", "medium", "large", "extra large"]
end

def crust_type()
  crust = ["regular", "thin", "deep dish"]
end

def meats()
  meats = ["bacon", "sausage", "ham", "chicken", "anchovies", "no meat"]
end

def veggies()
  veggies = ["onions", "peppers", "banana peppers", "tomatoes", "olives", "no veggies"]
end

def sauce()
  sauce = ["marinara", "white sauce", "barbecue sauce"]
end

def pizza(size, topping, cheese, sauce)
  puts "You ordered a #{size} pizza, with #{crust_type} crust, #{sauce}, #{meats}, and #{veggies}."
end
