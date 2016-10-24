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
    return Pub.map_items(sql)
    sql = "SELECT * FROM pubs WHERE vote2_id = #{@id}"
    pub_data2 = SqlRunner.run(sql)
    score2 = pub_data2.map { |pub_data| Pub.new(pub_data) }
    sql = "SELECT * FROM pubs WHERE vote3_id = #{@id}"
    pub_data3 = SqlRunner.run(sql)
    score3 = pub_data3.map { |pub_data| Pub.new(pub_data) }
    total_score = score1.length + score2.length + score3.length

    # "SELECT pubs. * FROM pubs INNER JOIN votes ON vote1_id = pubs.id WHERE rentals.pub_id = #{@id}"
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