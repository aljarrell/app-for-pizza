require 'sinatra'
require_relative 'mypizza.rb'

get '/' do
  erb :home
end

post '/home' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  if params[:meats]
    meats = params[:meats].join(", ")
  else
    meats = "no meat"
  end
  if params[:veggies]
    veggies = params[:veggies].join(", ")
  else
    veggies = "no veggies"
  end
  redirect 'confirm_order?size=' + size + '&crust=' + crust + '&sauce=' + sauce + '&meats=' + meats + '&veggies=' + veggies
end

get '/confirm_order' do
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
  pizza_ingredients = Array.new
  pizza_ingredients.push(size, crust, sauce, meats, veggies)
  p "this is PIZZA ingredients #{pizza_ingredients}"
  p "this is PARAMS #{params}"
  erb :confirm_order, locals: {pizza_ingredients: pizza_ingredients}
end

post '/confirm_order' do
  pizza_ingredients = params[:pizza_ingredients]
  redirect '/delivery?pizza_ingredients=' + pizza_ingredients
end

get '/delivery' do
  pizza_ingredients = params[:pizza_ingredients]
  erb :delivery, locals: {pizza_ingredients: pizza_ingredients}
end

post '/delivery' do
  pizza_ingredients = params[:pizza_ingredients]
  delivery_option = params[:delivery_option]
  #p "this is POST params #{params}"
  if params[:delivery_option] == "take out"
    redirect '/final_order?pizza_ingredients=' + pizza_ingredients + '&delivery_option=' + delivery_option
  else
    redirect '/address?pizza_ingredients=' + pizza_ingredients + '&delivery_option=' + delivery_option
  end
end

get '/address' do
  pizza_ingredients = params[:pizza_ingredients]
  delivery_option = params[:delivery_option]
  erb :address, locals: {pizza_ingredients: pizza_ingredients, delivery_option: delivery_option}
end

post '/address' do
  pizza_ingredients = params[:pizza_ingredients]
  address = params[:address]
  redirect '/final_order?pizza_ingredients=' + pizza_ingredients + '&address=' + address
end

get '/final_order' do
  pizza_ingredients = params[:pizza_ingredients]
  address = params[:address]
  erb :final_order, locals: {pizza_ingredients: pizza_ingredients, address: address}
end
