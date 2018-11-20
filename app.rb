require 'sinatra'
require_relative 'mypizza.rb'

get '/' do
  erb :home
end

post '/home' do
  size = params[:size]
  crust = params[:crust]
  redirect 'confirm_order?size=' + size + '&crust=' + crust
end

get '/confirm_order' do
  size = params[:size]
  crust = params[:crust]
  erb :confirm_order, locals: {size: size, crust: crust}
end
