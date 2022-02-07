require 'bundler'
require 'gossip'
Bundler.require

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new' do
    erb :new_gossip
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.all[params[:id].to_i], id: params[:id].to_i}
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.all[params[:id].to_i], id: params[:id].to_i}
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  post '/gossips/:id/edit' do
		Gossip.update(params["gossip_author"], params["gossip_content"],params[:id].to_i)
		redirect '/'
	end

  run! if app_file  == $0
end


