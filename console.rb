require_relative( './models/pub' )
require_relative( './models/vote' )
require_relative( './db/sql_runner' )
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

vote1 = Vote.new( 'pub_id' => 1, 'vote1' => 'The Bow Bar', 'vote2' => 'The Three Sisters', 'vote3' => 'Cloisters Bar' )
vote1.save()
vote2 = Vote.new( 'pub_id' => 2, 'vote1' => 'Deacon Brodies Tavern', 'vote2' => 'Worlds End', 'vote3' => 'Cloisters Bar' )
vote2.save()
vote3 = Vote.new( 'pub_id' => 3, 'vote1' => 'The Last Drop', 'vote2' => 'Worlds End', 'vote3' => 'Cloisters Bar')
vote3.save()
vote4 = Vote.new( 'pub_id' => 4, 'vote1' => 'The Three Sisters', 'vote2' => 'Worlds End', 'vote3' => 'The Bow Bar' )
vote4.save()
vote5 = Vote.new( 'pub_id' => 5, 'vote1' => 'The Last Drop', 'vote2' => 'The Bow Bar', 'vote3' => 'Cloisters Bar' )
vote5.save()
vote6 = Vote.new( 'pub_id' => 6, 'vote1' => 'The Bow Bar', 'vote2' => 'Deacon Brodies Tavern', 'vote3' => 'The Last Drop' )
vote6.save()



binding.pry
nil