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
  voted = false
  double_vote = false
  self_vote = false
  first_vote = params["vote1_id"].to_i
  second_vote = params["vote2_id"].to_i
  third_vote = params["vote3_id"].to_i
  pub_id_number = params["pub_id"].to_i
    
  # decide if a pub has already voted

  @votes.each do |vote|
    if vote.pub_id == pub_id_number
      voted = true
    end
  end

  # decide if a pub has voted for the same pub more than once

  if first_vote == second_vote || first_vote == third_vote
    double_vote = true
  elsif second_vote == third_vote
    double_vote = true
  end

  # decide if a pub has voted for itself

  if first_vote == pub_id_number || second_vote == pub_id_number
    self_vote = true
  elsif third_vote == pub_id_number
    self_vote = true
  end

  # redirect user to error message or save vote

  if voted == true
    redirect to("/")
  elsif double_vote == true
    redirect to("/")
  elsif self_vote
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