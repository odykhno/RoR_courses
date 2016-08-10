require 'yaml'
require 'net/http'
require 'json'

VK_CONF = YAML.load(File.read('./config.yml'))['vk']
vk_domen = VK_CONF['domen']
con_path = VK_CONF['methods']['countries'] + '?need_all=1&count=1000'
cit_path = VK_CONF['methods']['cities'] + '?count=1000'
uni_path = VK_CONF['methods']['universities'] + '?count=10000'


response = Net::HTTP.get(vk_domen, con_path)
response = JSON.parse(response)['response']

Dir.mkdir("Data")
threads = []
response.each do |elem|
  threads << Thread.new do
    Dir.mkdir("Data/" + elem['title'])
    res = Net::HTTP.get(vk_domen, cit_path + "&country_id=#{elem['cid']}")
    res = JSON.parse(res)['response']
    res.each do |el|
      uni_res = Net::HTTP.get(vk_domen, uni_path + "&city_id=#{el['cid']}")
      uni_res = JSON.parse(uni_res)['response']
      uni_res.delete_at(0)
      uni_res.each do |uni|
        File.open("Data/" + elem['title'] + "/#{el['title']}.txt", 'a'){ |file| file.puts uni['title']}
      end
    end
  end
end
threads.each { |thr| thr.join }

