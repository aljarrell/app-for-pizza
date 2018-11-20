require 'sinatra'
require_relative 'mypizza.rb'

get '/' do
  erb :home
end

post '/home' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats].join(", ")
  redirect 'confirm_order?size=' + size + '&crust=' + crust + '&sauce=' + sauce + '&meats=' + meats
end

get '/confirm_order' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  meats = params[:meats]
  erb :confirm_order, locals: {size: size, crust: crust, sauce: sauce, meats: meats}
end
