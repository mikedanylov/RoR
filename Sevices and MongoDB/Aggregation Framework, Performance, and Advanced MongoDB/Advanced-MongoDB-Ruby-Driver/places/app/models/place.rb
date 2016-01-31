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
		@id = hash[:_id].to_s if hash.key?(:_id)
		@address_components = []
		if hash.key?(:address_components)
			for address in hash[:address_components]
				@address_components.push(AddressComponent.new(address))
			end
		end 
		@formatted_address = hash[:formatted_address] if hash.key?(:formatted_address)
		@location = hash[:geometry][:geolocation] if hash.key?(:geometry)
	end

end
