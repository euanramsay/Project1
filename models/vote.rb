require( 'pg' )
require( 'pry-byebug' )
require_relative('../db/sql_runner')

class Vote

  attr_reader( :pub_id, :vote1_id, :vote2_id, :vote3_id )

  def initialize( options )
    @pub_id = options['pub_id']
    @vote1_id = options['vote1_id'].to_i
    @vote2_id = options['vote2_id'].to_i
    @vote3_id = options['vote3_id'].to_i
  end

  def save()
    sql = "UPDATE pubs SET vote1_id = #{@vote1_id}, vote2_id =  #{@vote2_id}, vote3_id = #{vote3_id} WHERE id = #{pub_id}"
    pub_data = SqlRunner.run(sql)
  end


end