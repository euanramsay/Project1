require 'pry-byebug'
require_relative('../models/vote')
require_relative('../models/pub')

#index
get '/votes' do
  @votes = Vote.all
  @pubs = Pub.all_sorted
  # binding.pry
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
  invalid_vote = false
  invalid_vote = Vote.valid_vote?(params)

  if invalid_vote == true
    message = "Invalid vote"
    redirect to( "/votes/new" )

    #append a query paramater to the /votes/new
    #on the /votes/new erb, display the message if it exists in the params hash
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

