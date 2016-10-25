require 'pry-byebug'
require_relative('../models/vote')
require_relative('../models/pub')

#index
get '/votes' do
  @votes = Vote.all
  @pubs = Pub.all
  erb(:'votes/index')
end

#new
get '/votes/new' do
  @votes = Vote.all
  @pubs = Pub.all
  erb(:'votes/new')
end

#create
post '/votes' do
  @vote = Vote.new(params)
  @vote.save
  redirect to( "/votes" )
end

#show
get '/votes/:id' do
  @vote = Vote.find(params['id'])
  erb(:'votes/show')
end

#edit
get '/votes/:id/edit' do
end

#update
post '/votes/:id' do
end

#delete
delete '/votes' do
end