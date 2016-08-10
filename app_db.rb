require 'sqlite3'
require 'yaml'
require 'json'
require 'net/http'

VK_CONF = YAML.load(File.read('./config.yml'))['vk']
vk_domen = VK_CONF['domen']
con_path = VK_CONF['methods']['countries'] + '?need_all=1&count=1000'
reg_path = VK_CONF['methods']['regions'] + '?count=1000'

db = SQLite3::Database.new "api_vk_db.sqlite"

db.execute ("CREATE TABLE [countries] ( [title] VARCHAR(50), [cid] INT );")
db.execute ("CREATE TABLE [regions] ( [cid] INT, [title] VARCHAR(50), [region_id] INT );")

response_con = Net::HTTP.get(vk_domen, con_path)
response_con = JSON.parse(response_con)['response']

response_con.each do |elem_con|
  response_reg = Net::HTTP.get(vk_domen, reg_path + "&country_id=#{elem_con['cid']}")
  response_reg = JSON.parse(response_reg)['response']
  db.execute('INSERT INTO countries (title, cid) VALUES (?, ?)', [elem_con['title'], elem_con['cid']])
  response_reg.each do |elem_reg|
    db.execute('INSERT INTO regions (cid, title, region_id) VALUES (?, ?, ?)', [elem_con['cid'], elem_reg['title'], elem_reg['region_id']])
  end
end

p db
