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
  @pub = Pub.find(params['id'])
  erb(:'pubs/edit')
  # @pub.save
end

#update
post '/pubs/:id' do
  @pub = Pub.update( params )
  redirect to( "/pubs/#{params[:id]}" )
end

#delete
delete '/pubs/:id' do
  Pub.destroy( params[:id] )
  redirect to('/pubs')
end