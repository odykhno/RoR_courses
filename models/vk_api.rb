require 'sqlite3'

class VkApi

  def initialize
    @db = SQLite3::Database.new "api_vk_db.sqlite"
  end

  def countries
    @countries = @db.execute('SELECT * FROM countries')
  end

  def regions(country_id)
    @regions = @db.execute("SELECT * FROM regions WHERE cid = #{country_id}")
  end

end