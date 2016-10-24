require( 'pg' )
require( 'pry-byebug' )
require_relative('../db/sql_runner')
require_relative( '../models/vote' )

class Pub

  attr_reader( :id, :name, :postcode )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @postcode = options['postcode']
  end

  def save()
    sql = "INSERT INTO pubs (name, postcode) VALUES ('#{@name}', '#{@postcode}') RETURNING *"
    pub_data = SqlRunner.run(sql).first
    @id = pub_data['id'].to_i
  end

  # def total_score()
    
  # end

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