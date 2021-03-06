require_relative( '../db/sql_runner' )

class Cocktail

  attr_reader :id, :name, :ing_list_id, :prep_description

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @ing_list_id = options['ing_list_id'].to_i
    @prep_description = options['prep_description']
  end

  def save()
    sql = "INSERT INTO cocktails (name, ing_list_id, prep_description) VALUES ( '#{@name}', #{@ing_list_id}, '#{@prep_description}') RETURNING *"
    results = SqlRunner.run(sql)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE cocktails SET (name, ing_list_id, prep_description) = ( '#{@name}', #{@ing_list_id}, '#{@prep_description}') WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM cocktails WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM cocktails"
    SqlRunner.run( sql )
  end

  def self.all
    sql = "SELECT * FROM cocktails"
    results = SqlRunner.run( sql )
    return results.map { |hash| Cocktail.new( hash ) }
  end

  def self.find( id )
    sql = "SELECT * FROM cocktails WHERE id = #{id}"
    results = SqlRunner.run( sql )
    return Cocktail.new( results.first )
  end

  def self.map_items(sql)
    cocktails = SqlRunner.run(sql)
    return cocktails.map { |cocktail| Cocktail.new(cocktail) }
  end

end

# Is it possible to pull info from my cocktails table from my measures table? 
# Does a method have to be a self method to be used in a controller file? 

