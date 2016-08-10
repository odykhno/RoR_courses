require 'haml'
require './models/vk_api'

class IndexController
  def initialize(response)
    @response = response
  end

  def countries
    @countries = VkApi.new.countries
    @response.body = render
  end

  private

  def render
    ERB.new(File.read('./views/index.html.erb')).result(binding)
    # Haml::Engine.new(File.read('./views/index.html.haml')).render(binding)
  end
end