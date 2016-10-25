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

 def update_score()
   sql = "SELECT * FROM votes WHERE vote1_id = #{@id}"
   score1 = Vote.map_items(sql)
   sql = "SELECT * FROM votes WHERE vote2_id = #{@id}"
   score2 = Vote.map_items(sql)
   sql = "SELECT * FROM votes WHERE vote3_id = #{@id}"
   score3 = Vote.map_items(sql)
   total_score = score1.length + score2.length + score3.length
   sql = "UPDATE pubs SET score = #{total_score} WHERE id = #{@id}"
   SqlRunner.run(sql)
   @score = total_score
 end

  def self.all()
    sql = "SELECT * FROM pubs"
    return Pub.map_items(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM pubs WHERE id = #{id}"
    return Pub.map_item(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM pubs"
    SqlRunner.run(sql)
  end


  def self.map_items(sql)
    pubs = SqlRunner.run(sql)
    result = pubs.map { |pub| Pub.new( pub ) }
    return result
  end

  def self.map_item(sql)
    result = Pub.map_items(sql)
    return result.first
  end

end