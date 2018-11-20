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
  delivery = params[:delivery]
  redirect 'confirm_order?size=' + size + '&crust=' + crust + '&sauce=' + sauce + '&meats=' + meats + '&veggies=' + veggies + '&delivery=' + delivery
end

get '/confirm_order' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  veggies = params[:veggies]
  delivery = params[:delivery]
  erb :confirm_order, locals: {size: size, crust: crust, sauce: sauce, meats: meats, veggies: veggies, delivery: delivery}
end
