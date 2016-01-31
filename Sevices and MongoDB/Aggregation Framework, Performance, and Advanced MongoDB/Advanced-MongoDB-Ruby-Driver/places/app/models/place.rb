class Place
	include Mongoid::Document
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

end
