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

  def total_score()
    sql = "SELECT * FROM votes WHERE vote1_id = #{@pub_id}"
    score1 = Pub.map_items(sql)
    sql = "SELECT * FROM votes WHERE vote2_id = #{@pub_id}"
    score2 = Pub.map_items(sql)
    sql = "SELECT * FROM votes WHERE vote3_id = #{@pub_id}"
    score3 = Pub.map_items(sql)
    total_score = score1.length + score2.length + score3.length
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