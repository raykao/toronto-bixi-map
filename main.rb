require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'faraday'
require 'active_support/core_ext/hash'
require 'json'
require 'coffee-script'

# File.open(latest.json, 'w') {|f| f.write(doc) }

def get_bixi_data
	con = Faraday.new
	request = con.get 'https://toronto.bixi.com/data/bikeStations.xml'
	request.body
end

get '/' do
	if Time.now > (File.mtime('public/latest.json') + 1.minutes)
		data = get_bixi_data
		data = Hash.from_xml(data).to_json
		file = File.new('public/latest.json', 'w')
		file.write(data)
		file.close
		"Generated new latest.json"
	end

	erb :index
end

get '/application.js' do 
	coffee :application
end