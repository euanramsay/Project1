require( 'pg' )
require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative( '../models/pub' )

class Vote

  attr_reader( :pub_id, :vote1_id, :vote2_id, :vote3_id )

  def initialize( options )
    @pub_id = options['pub_id']
    @vote1_id = options['vote1_id'].to_i
    @vote2_id = options['vote2_id'].to_i
    @vote3_id = options['vote3_id'].to_i
  end


  def save()
    sql = "INSERT INTO votes (pub_id, vote1_id, vote2_id, vote3_id) VALUES (#{@pub_id}, #{@vote1_id}, #{@vote2_id}, #{@vote3_id}) RETURNING *"
    vote_data = SqlRunner.run(sql).first
    @id = vote_data['id'].to_i
  end


end