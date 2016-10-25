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
  @votes = Vote.all
  @voted = false
  pub_id_number = params["pub_id"].to_i
    @votes.each do |vote|
      if vote.pub_id == pub_id_number
        @voted = true
      end
    end
  if @voted == true
    redirect to("/")
  else
    @vote.save
    redirect to( "/votes" )
  end
end

#show
get '/votes/:id' do
  @vote = Vote.find(params['id'])
  erb(:'votes/show')
end

#edit
get '/votes/:id/edit' do
  @vote = Vote.find(params['id'])
  @pub = Pub.find(params['id'])
  erb(:'votes/edit')
end

#update
post '/votes/:id' do
end

#delete
delete '/votes' do
end