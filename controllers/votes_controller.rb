require 'pry-byebug'
require_relative('../models/vote')
require_relative('../models/pub')
enable :sessions

#index
get '/votes' do
  Pub.update_all_scores()
  @pubs = Pub.all_sorted()
  # binding.pry
  erb(:'votes/index')
end

#new
get '/votes/new' do
  @votes = Vote.all
  @pubs = Pub.all
  if params['invalid_vote'] == 'true'
    @message = "INVALID VOTE! A pub can only submit votes once and can not vote for itself. Votes must be unique."
  end
  erb(:'votes/new')
end

#create
post '/votes' do
  @vote = Vote.new(params)
  invalid_vote = false
  invalid_vote = Vote.valid_vote?(params)

  if invalid_vote #== true
    redirect to('/votes/new?invalid_vote=true')

  else
    @vote.save
    redirect to( "/votes" )
    binding.pry
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
  @pubs = Pub.all()
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

