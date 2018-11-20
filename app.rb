require 'sinatra'
require_relative 'mypizza.rb'

get '/' do
  erb :home
end

post '/home' do
  size = params[:size]
  redirect 'confirm_order?size=' + size
end

get '/confirm_order' do
  size = params[:size]
  erb :confirm_order, locals: {size: size}
end
