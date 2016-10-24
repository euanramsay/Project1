require( 'pg' )
require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative( '../models/vote' )

class Pub

  attr_reader( :id, :name, :postcode, :score )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @postcode = options['postcode']
    @score = options['score'].to_i
  end

  def save()
    sql = "INSERT INTO pubs (name, postcode) VALUES ('#{@name}', '#{@postcode}') RETURNING *"
    pub_data = SqlRunner.run(sql).first
    @id = pub_data['id'].to_i
  end

  def total_score()
    sql = "SELECT * FROM pubs WHERE vote1_id = #{@id}"
    pub_data1 = SqlRunner.run(sql)
    score1 = pub_data1.map { |pub_data| Pub.new(pub_data) }
    sql = "SELECT * FROM pubs WHERE vote2_id = #{@id}"
    pub_data2 = SqlRunner.run(sql)
    score2 = pub_data2.map { |pub_data| Pub.new(pub_data) }
    sql = "SELECT * FROM pubs WHERE vote3_id = #{@id}"
    pub_data3 = SqlRunner.run(sql)
    score3 = pub_data3.map { |pub_data| Pub.new(pub_data) }
    total_score = score1.length + score2.length + score3.length
  end

  def save_score()
    
  end

end