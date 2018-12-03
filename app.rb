require 'sinatra'
require_relative 'price.rb'

get '/' do
  pizza_list = params[:pizza_list] if params[:pizza_list]
  pizza_list = "" if !params[:pizza_list]
  erb :home, locals: {pizza_list: pizza_list}
end

post '/home' do
    pizza_list = params[:pizza_list]
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
    pizza_list = Array.new if params[:pizza_list] == ""
    temp_arr = Array.new
    temp_arr.push(size, crust, sauce, meats, veggies)
    number_of_pizzas.to_i.times do
      pizza_list.push(temp_arr)
    end
    pizza_list = pizza_list.join(",")
    redirect 'confirm_order?pizza_list=' + pizza_list + '&number_of_pizzas=' + number_of_pizzas
end

get '/confirm_order' do
  number_of_pizzas = params[:number_of_pizzas].to_i
  pizza_list = params[:pizza_list]
  p "this is PIZZA ingredients #{pizza_list}"
  erb :confirm_order, locals: {pizza_list: pizza_list, number_of_pizzas: number_of_pizzas}
end

post '/confirm_order' do
  number_of_pizzas = params[:number_of_pizzas].to_s
  pizza_list = params[:pizza_list]
    #p "this is PIZZA ingredients #{pizza_list}"
    #p "this is NUMBER #{number_of_pizzas}"
  redirect '/delivery?pizza_list=' + pizza_list + '&number_of_pizzas=' + number_of_pizzas
end

get '/delivery' do
  number_of_pizzas = params[:number_of_pizzas]
  pizza_list = params[:pizza_list]
  #p "this is PIZZA ingredients #{pizza_ingredients}"
  erb :delivery, locals: {pizza_list: pizza_list, number_of_pizzas: number_of_pizzas}
end

post '/delivery' do
  number_of_pizzas = params[:number_of_pizzas]
  pizza_list = params[:pizza_list]
  delivery_option = params[:delivery_option]
  #p "this is POST params #{params}"
  if params[:delivery_option] == "take out"
    redirect '/final_order?pizza_list=' + pizza_list + '&delivery_option=' + delivery_option + '&number_of_pizzas=' + number_of_pizzas
  elsif params[:delivery_option] == "delivery"
    redirect '/address?pizza_list=' + pizza_list + '&delivery_option=' + delivery_option + '&number_of_pizzas=' + number_of_pizzas
  elsif params[:delivery_option] == "add pizza"
    redirect '/?pizza_list=' + pizza_list
  end
end

get '/address' do
  number_of_pizzas = params[:number_of_pizzas]
  pizza_list = params[:pizza_list]
  delivery_option = params[:delivery_option]
  erb :address, locals: {pizza_list: pizza_list, delivery_option: delivery_option, number_of_pizzas: number_of_pizzas}
end

post '/address' do
  number_of_pizzas = params[:number_of_pizzas]
  pizza_list = params[:pizza_list]
  address = params[:address]
  redirect '/final_order?pizza_list=' + pizza_list + '&address=' + address + '&number_of_pizzas=' + number_of_pizzas
end

get '/final_order' do
  number_of_pizzas = params[:number_of_pizzas].to_i
  pizza_list = params[:pizza_list]
  address = params[:address]
  total = price(pizza_list.split(",").length, pizza_list.split(","))
  erb :final_order, locals: {pizza_list: pizza_list, address: address, total: total, number_of_pizzas: number_of_pizzas}
end
