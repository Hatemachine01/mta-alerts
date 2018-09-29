require 'protobuf'
require 'google/transit/gtfs-realtime.pb'
require 'net/http'
require 'uri'
require 'json'
require 'sinatra'


def get_data
	data = Net::HTTP.get(URI.parse('http://datamine.mta.info/mta_esi.php?key=7bbeed35b802b47be87046adcf1d664f&feed_id=21'))
	feed = Transit_realtime::FeedMessage.decode(data)
	trip_data = []
		for entity in feed.entity do 
				if entity.field?(:trip_update)
					trip_data << entity.trip_update
				end
			end
		trip_data.to_json
	end




get '/' do
	get_data
end