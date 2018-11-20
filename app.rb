require 'sinatra'
require_relative 'mypizza.rb'

get '/' do
  erb :home
end

post '/home' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  redirect 'confirm_order?size=' + size + '&crust=' + crust + '&sauce=' + sauce
end

get '/confirm_order' do
  size = params[:size]
  crust = params[:crust]
  sauce = params[:sauce]
  erb :confirm_order, locals: {size: size, crust: crust, sauce: sauce}
end
