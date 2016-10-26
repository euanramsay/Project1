require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/pubs_controller')
require_relative('controllers/votes_controller')


get '/' do
  erb :home
end