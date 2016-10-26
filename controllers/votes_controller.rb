require 'pry-byebug'
require_relative('../models/vote')
require_relative('../models/pub')
enable :sessions

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
  if params['invalid_vote'] == 'true'
    @message = "Invalid vote"
  end
  erb(:'votes/new')
end

#create
post '/votes' do
  @vote = Vote.new(params)
  invalid_vote = false
  invalid_vote = Vote.valid_vote?(params)

  # if Vote.valid_vote?(@vote)
  #   @message = "Invalid vote"
  #   redirect to( "/votes/new" )
# binding.pry

  if invalid_vote #== true
    redirect to('/votes/new?invalid_vote=true')

    
    # @votes = Vote.all
    # @pubs = Pub.all
    # @message = "Invalid vote"
    # erb(:'votes/new')
  else
    @vote.save
    redirect to( "/votes" )
    binding.pry
  end
end

# binding.pry

    # redirect to('/votes/new?invalid_vote=true')

    #append a query paramater to the /votes/new
    #on the /votes/new erb, display the message if it exists in the params hash

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
  @vote = Vote.update( params )
  redirect to( "/votes/#{params[:id]}" )
end

#delete
delete '/votes' do
  Vote.destroy( params[:id] )
  redirect to('/votes')
end

