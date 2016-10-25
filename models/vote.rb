require( 'pg' )
require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative( '../models/pub' )

class Vote

  attr_reader( :id, :pub_id, :vote1, :vote2, :vote3, :score)

  def initialize( options )
    @id = options['id'].to_i
    @pub_id = options['pub_id']
    @vote1 = options['vote1']
    @vote2 = options['vote2']
    @vote3 = options['vote3']
    @score = options['score'].to_i
  end


  def save()
    sql = "INSERT INTO votes (pub_id, vote1, vote2, vote3) VALUES (#{@pub_id}, '#{@vote1}', '#{@vote2}', '#{@vote3}') RETURNING *"
    vote_data = SqlRunner.run(sql).first
    @id = vote_data['id'].to_i
  end

  # def update_score()
  #   sql = "SELECT * FROM votes WHERE vote1_id = #{@pub_id}"
  #   score1 = Vote.map_items(sql)
  #   sql = "SELECT * FROM votes WHERE vote2_id = #{@pub_id}"
  #   score2 = Vote.map_items(sql)
  #   sql = "SELECT * FROM votes WHERE vote3_id = #{@pub_id}"
  #   score3 = Vote.map_items(sql)
  #   total_score = score1.length + score2.length + score3.length
  #   sql = "UPDATE votes SET score = #{total_score} WHERE pub_id = #{@pub_id}"
  #   SqlRunner.run(sql)
  #   return total_score
  # end

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