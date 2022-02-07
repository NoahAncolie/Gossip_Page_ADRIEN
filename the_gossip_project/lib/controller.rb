require 'bundler'
require 'gossip'
require 'comment'
Bundler.require

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.all[params[:id].to_i], id: params[:id].to_i}
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.all[params[:id].to_i], id: params[:id].to_i}
  end

  post '/gossips/:id/edit' do
		Gossip.update(params["gossip_author"], params["gossip_content"],params[:id].to_i)
		redirect '/'
	end

  get '/gossips/:id/comment' do
    erb :comment, locals: {gossip: Gossip.all[params[:id].to_i], id: params[:id].to_i}
  end

  post '/gossips/:id/comment' do
    Comment.new(params["gossip_comment_name"], params["gossip_comment"], params[:id].to_i).save
    redirect "/gossips/#{params[:id]}"
  end

  run! if app_file  == $0
end


