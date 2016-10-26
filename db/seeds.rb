require_relative( '../models/pub' )
require_relative( '../models/vote' )
require_relative( 'sql_runner' )
require( 'pry-byebug' )

pub1 = Pub.new( { 'name' => 'The Last Drop', 'postcode' => 'EH1 2JR' } );
pub1.save()
pub2 = Pub.new( { 'name' => 'The Bow Bar', 'postcode' => 'EH1 2HH' } );
pub2.save()
pub3 = Pub.new( { 'name' => 'The Three Sisters', 'postcode' => 'EH1 1JS' } );
pub3.save()
pub4 = Pub.new( { 'name' => 'Cloisters Bar', 'postcode' => 'EH3 9JH' } );
pub4.save()
pub5 = Pub.new( { 'name' => 'Deacon Brodies Tavern', 'postcode' => 'EH1 2NT' } );
pub5.save()
pub6 = Pub.new( { 'name' => 'Worlds End', 'postcode' => 'EH1 1TB' } );
pub6.save()
pub7 = Pub.new( { 'name' => 'The Cumberland Bar', 'postcode' => 'EH3 6RT' } );
pub7.save()
pub8 = Pub.new( { 'name' => 'The Sheep Heid Inn', 'postcode' => 'EH15 3QA' } );
pub8.save()


vote1 = Vote.new( 'pub_id' => 1, 'vote1_id' => 3, 'vote2_id' => 4, 'vote3_id' => 6 )
vote1.save()
vote2 = Vote.new( 'pub_id' => 2, 'vote1_id' => 5, 'vote2_id' => 1, 'vote3_id' => 3 )
vote2.save()
vote3 = Vote.new( 'pub_id' => 3, 'vote1_id' => 6, 'vote2_id' => 1, 'vote3_id' => 5 )
vote3.save()






# binding.pry
# nil