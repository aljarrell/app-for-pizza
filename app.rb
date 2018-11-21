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
  meats = params[:meats]
  veggies = params[:veggies]
  erb :confirm_order, locals: {size: size, crust: crust, sauce: sauce, meats: meats, veggies: veggies}
end

post '/confirm_order' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  redirect 'delivery?size=' + size + '&crust=' + crust + '&sauce=' + sauce + '&meats=' + meats + '&veggies=' + veggies
end

get '/delivery' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  #p "this is GET params #{params}"
  erb :delivery, locals: {size: size, crust: crust, sauce: sauce, meats: meats, veggies: veggies}
end

post '/delivery' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  delivery_option = params[:delivery_option]
  #p "this is POST params #{params}"
  if params[:delivery_option] == "take out"
    redirect '/final_order?size=' + size + '&crust=' + crust + '&sauce=' + sauce + '&meats=' + meats + '&veggies=' + veggies + '&delivery_option=' + delivery_option
  else
    redirect '/address?size=' + size + '&crust=' + crust + '&sauce=' + sauce + '&meats=' + meats + '&veggies=' + veggies + '&delivery_option=' + delivery_option
  end
end

get '/address' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  delivery_option = params[:delivery_option]
  erb :address, locals: {size: size, crust: crust, sauce: sauce, meats: meats, veggies: veggies, delivery_option: delivery_option}
end

post '/address' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  address = params[:address]
  redirect '/final_order?size=' + size + '&crust=' + crust + '&sauce=' + sauce + '&meats=' + meats + '&veggies=' + veggies + '&address=' + address
end

get '/final_order' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  address = params[:address]
  erb :final_order, locals: {size: size, crust: crust, sauce: sauce, meats: meats, veggies: veggies, address: address}
end
