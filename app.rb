require 'sinatra'
require_relative 'mypizza.rb'

get '/' do
  erb :home
end

post '/home' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  if params[:meats].include?("no meat")
    meats = "no meat"
  else
    meats = params[:meats].join(", ")
  end

  if params[:veggies].include?("no veggies")
    veggies = "no veggies"
  else
    veggies = params[:veggies].join(", ")
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
  p "this is GET params #{params}"
  #delivery_option = params[:delivery_option]
  erb :delivery, locals: {size: size, crust: crust, sauce: sauce, meats: meats, veggies: veggies}
end

post '/delivery' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  delivery_option = params[:delivery_option]
  p "this is POST params #{params}"
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

get '/final_order' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  delivery_option = params[:delivery_option]
  erb :final_order, locals: {size: size, crust: crust, sauce: sauce, meats: meats, veggies: veggies, delivery_option: delivery_option}
end
