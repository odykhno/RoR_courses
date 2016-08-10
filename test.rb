require 'sqlite3'

# db = SQLite3::Database.new "api_vk_db.sqlite"
#
# countries = db.execute('SELECT * FROM countries')
# regions = db.execute('SELECT * FROM regions')
# p countries.last
#
# p regions = db.execute("SELECT * FROM regions WHERE cid = #{countries.last[1]}")

require 'yaml'
require 'net/http'
require 'json'

VK_CONF = YAML.load(File.read('./config.yml'))['vk']
vk_domen = VK_CONF['domen']
con_path = VK_CONF['methods']['countries'] + '?need_all=1&count=1000'
cit_path = VK_CONF['methods']['cities'] + '?count=1000'
uni_path = VK_CONF['methods']['universities'] + '?count=10000'

uni_res = Net::HTTP.get(vk_domen, uni_path + "&city_id=8")
uni_res = JSON.parse(uni_res)['response']
uni_res.delete_at(0)
p uni_res