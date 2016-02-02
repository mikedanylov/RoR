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
		@id = hash[:_id].to_s
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

	def self.find id
		elem = self.collection
					.find( { _id: BSON::ObjectId.from_string(id) } )
					.first
		return nil if elem == nil
		Place.new(elem)
	end

	def self.all(offset=0, limit=0)
		places = []
		self.collection.find().skip(offset).limit(limit)
			.each { |place| places.push(Place.new(place)) }
		return places
	end

	def destroy
		Place.collection.delete_one({
			_id: BSON::ObjectId.from_string(@id)
		})
	end

	def self.get_address_components(sort={_id: 1}, offset=0, limit=200)
		self.collection.find.aggregate([
			{ :$unwind => '$address_components' },
			{
				:$project => {
					address_components: 1,
					formatted_address: 1,
					geometry: {
						geolocation: 1
					}
				}
			},
			{ :$sort => sort },
			{ :$skip => offset },
			{ :$limit => limit}
		])
	end

	def self.get_country_names
		self.collection.find.aggregate([
			{ :$unwind => '$address_components' },
			{ :$project => {
					long_name: '$address_components.long_name',
					types: '$address_components.types'
				}
			},
			{ :$unwind => '$types' },
			{ :$match => { types: 'country' } },
			{ :$group => { _id: '$long_name' } }
		]).to_a.map {|h| h[:_id]}
	end

	def self.find_ids_by_country_code country_code
		self.collection.find.aggregate([
			{ :$unwind => '$address_components' },
			{ :$project => {
					short_name: '$address_components.short_name',
					types: '$address_components.types'
				}
			},
			{ :$unwind => '$types' },
			{ :$match =>
				{
					types: 'country',
					short_name: country_code
				}
			}
		]).to_a.map {|doc| doc[:_id].to_s}
	end

end