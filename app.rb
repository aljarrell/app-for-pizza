require 'sinatra'
require_relative 'price.rb'

get '/' do
  pizza_ingredients = params[:pizza_ingredients]
  p "this is PIZZA INGREDIENTS #{pizza_ingredients}"
   if params[:pizza_ingredients]
  pizza_ingredients = ""
  end
  erb :home, locals: {pizza_ingredients: pizza_ingredients}
end

post '/home' do
    pizza_ingredients = params[:pizza_ingredients]
    #p "this is PIZZA INGREDIENTS #{pizza_ingredients}"
    number_of_pizzas = params[:number_of_pizzas]
    size = params[:size]
    crust = params[:crust]
    sauce = params[:sauce]
    if params[:meats]
      meats = params[:meats].join(",")
    else
      meats = "no meat"
    end
    if params[:veggies]
      veggies = params[:veggies].join(",")
    else
      veggies = "no veggies"
    end
    redirect 'confirm_order?size=' + size + '&crust=' + crust + '&sauce=' + sauce + '&meats=' + meats + '&veggies=' + veggies + '&number_of_pizzas=' + number_of_pizzas + '&pizza_ingredients=' + pizza_ingredients
end

get '/confirm_order' do
  number_of_pizzas = params[:number_of_pizzas].to_i
  #p "this is NUMBER OF PIZZAS #{number_of_pizzas}"
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  if params[:meats]
    meats = params[:meats]
  else
    meats = "no meat"
  end
  if params[:veggies]
    veggies = params[:veggies]
  else
    veggies = "no veggies"
  end
  temp_arr = Array.new
  pizza_ingredients = Array.new
  temp_arr.push(size, crust, sauce, meats, veggies)
  number_of_pizzas.times do
    #p "BEFORE PUSH #{pizza_ingredients}"
    pizza_ingredients.push(temp_arr).join(",")
    #p "AFTER PUSH #{pizza_ingredients}"
  end
  #p "this is PIZZA ingredients #{pizza_ingredients}"
  #p "this is PARAMS #{params}"
  erb :confirm_order, locals: {pizza_ingredients: pizza_ingredients, number_of_pizzas: number_of_pizzas}
end

post '/confirm_order' do
  number_of_pizzas = params[:number_of_pizzas].to_s
  pizza_ingredients = params[:pizza_ingredients]
    #p "this is PIZZA ingredients #{pizza_ingredients}"
    #p "this is NUMBER #{number_of_pizzas}"
  redirect '/delivery?pizza_ingredients=' + pizza_ingredients + '&number_of_pizzas=' + number_of_pizzas
end

get '/delivery' do
  number_of_pizzas = params[:number_of_pizzas]
  pizza_ingredients = params[:pizza_ingredients]
  #p "this is PIZZA ingredients #{pizza_ingredients}"
  erb :delivery, locals: {pizza_ingredients: pizza_ingredients, number_of_pizzas: number_of_pizzas}
end

post '/delivery' do
  number_of_pizzas = params[:number_of_pizzas]
  pizza_ingredients = params[:pizza_ingredients]
  delivery_option = params[:delivery_option]
  #p "this is POST params #{params}"
  if params[:delivery_option] == "take out"
    redirect '/final_order?pizza_ingredients=' + pizza_ingredients + '&delivery_option=' + delivery_option + '&number_of_pizzas=' + number_of_pizzas
  elsif params[:delivery_option] == "delivery"
    redirect '/address?pizza_ingredients=' + pizza_ingredients + '&delivery_option=' + delivery_option + '&number_of_pizzas=' + number_of_pizzas
  elsif params[:delivery_option] == "add pizza"
    redirect '/?pizza_ingredients=' + pizza_ingredients
  end
end

get '/address' do
  number_of_pizzas = params[:number_of_pizzas]
  pizza_ingredients = params[:pizza_ingredients]
  delivery_option = params[:delivery_option]
  erb :address, locals: {pizza_ingredients: pizza_ingredients, delivery_option: delivery_option, number_of_pizzas: number_of_pizzas}
end

post '/address' do
  number_of_pizzas = params[:number_of_pizzas]
  pizza_ingredients = params[:pizza_ingredients]
  address = params[:address]
  redirect '/final_order?pizza_ingredients=' + pizza_ingredients + '&address=' + address + '&number_of_pizzas=' + number_of_pizzas
end

get '/final_order' do
  number_of_pizzas = params[:number_of_pizzas].to_i
  pizza_ingredients = params[:pizza_ingredients]
  address = params[:address]
  total = price(pizza_ingredients.split(",").length, pizza_ingredients.split(","))
  erb :final_order, locals: {pizza_ingredients: pizza_ingredients, address: address, total: total, number_of_pizzas: number_of_pizzas}
end
