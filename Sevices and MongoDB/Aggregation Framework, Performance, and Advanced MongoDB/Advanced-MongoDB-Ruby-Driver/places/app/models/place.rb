require 'pp'

class Place
	include Mongoid::Document
	attr_accessor :id, :formatted_address, :location, :address_components

	MONGO_URL='mongodb://localhost:27017'
	MONGO_DATABASE='test'
	RACE_COLLECTION='race1'
	
	def self.mongo_client
		url = ENV['MONGO_URL'] ||= MONGO_URL
		database = ENV['MONGO_DATABASE'] ||= MONGO_DATABASE
		db = Mongo::Client.new(url)
		@@db = db.use(database)
	end

	def self.collection
		collection = ENV['RACE_COLLECTION'] ||= RACE_COLLECTION
		return mongo_client[collection]
	end

	def self.load_all file_path
		coll = JSON.parse(File.read(file_path))
		self.collection.insert_many(coll)
	end

	def initialize hash
		@id = hash[:_id].to_s if hash[:_id]
		@address_components = []
		for address in hash[:address_components]
			@address_components.push(AddressComponent.new(address))
		end
		@formatted_address = hash[:formatted_address] if hash[:formatted_address]
		@location = Point.new(hash[:geometry][:geolocation])
	end

	def self.find_by_short_name name
		Place.collection.find({
			address_components: {
				:$elemMatch => {
					short_name: name
				}					
			}
		})
	end

	def self.to_places mongo_coll_view
		places = []
		mongo_coll_view.each do |hash|
			places.push(Place.new(hash))
		end
		return places
	end

end
