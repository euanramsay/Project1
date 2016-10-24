require 'pry-byebug'
require_relative('../models/pub')

#index
get '/pubs' do
  @pubs = Pub.all
  erb(:'pubs/index')
end

#new
get '/pubs/new' do
  erb(:'pubs/new')
end

#create
post '/pubs' do
  @pub = Pub.new(params)
  @pub.save
  redirect to( "pubs" )
end

#show
get '/pubs/:id' do
  @pub = Pub.find(params['id'])
  erb(:'pubs/show')
end

#edit
get '/pubs/:id/edit' do
end

#update
post '/pubs/:id' do
end

#delete
delete '/pubs' do
end