require( 'pg' )
require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative( '../models/pub' )

class Vote

  attr_reader( :id, :pub_id, :vote1_id, :vote2_id, :vote3_id )

  def initialize( options )
    @id = options['id'].to_i
    @pub_id = options['pub_id'].to_i
    @vote1_id = options['vote1_id'].to_i
    @vote2_id = options['vote2_id'].to_i
    @vote3_id = options['vote3_id'].to_i
  end


  def save()
    sql = "INSERT INTO votes (pub_id, vote1_id, vote2_id, vote3_id) VALUES (#{@pub_id}, #{@vote1_id}, #{@vote2_id}, #{@vote3_id}) RETURNING *"
    vote_data = SqlRunner.run(sql).first
    @id = vote_data['id'].to_i
  end

  def voting_pub()
    sql = "SELECT * FROM pubs WHERE pubs.id = #{@pub_id}"
    pubs = SqlRunner.run(sql)
    result = pubs.map { |pub| Pub.new( pub ) }
    return result
  end

  def self.valid_vote?(params)

  @votes = Vote.all
  @invalid_vote = false
  first_vote = params["vote1_id"].to_i
  second_vote = params["vote2_id"].to_i
  third_vote = params["vote3_id"].to_i
  pub_id_number = params["pub_id"].to_i
    
  # decide if a pub has already voted

  @votes.each do |vote|
    if vote.pub_id == pub_id_number
      @invalid_vote = true
    end
  end

  # decide if a pub has voted for the same pub more than once

  if first_vote == second_vote || first_vote == third_vote
    @invalid_vote = true
  elsif second_vote == third_vote
    @invalid_vote = true
  end

  # decide if a pub has voted for itself

  if first_vote == pub_id_number || second_vote == pub_id_number
    @invalid_vote = true
  elsif third_vote == pub_id_number
    @invalid_vote = true
  end

  return @invalid_vote

end

  def self.all()
    sql = "SELECT * FROM votes"
    return Vote.map_items(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM votes WHERE id = #{id}"
    return Vote.map_item(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM votes"
    SqlRunner.run(sql)
  end

  def self.update( options )
      sql = "UPDATE pubs SET pub_id=#{options['pub_id']}, 
        vote1_id = #{options['vote1_id']}, vote2_id = #{options['vote2_id']}, vote3_id = #{options['vote3_id']} WHERE id=#{options['id']}"
      SqlRunner.run(sql)
  end

  def self.map_items(sql)
    votes = SqlRunner.run(sql)
    result = votes.map { |vote| Vote.new( vote ) }
    return result
  end

  def self.map_item(sql)
    result = Vote.map_items(sql)
    return result.first
  end

end