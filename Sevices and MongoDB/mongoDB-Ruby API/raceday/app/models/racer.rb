# require 'mongo'
# require 'json'

class Racer
	
	MONGO_URL = 'mongodb://localhost:27017'
	MONGO_DATABASE = 'raceday_development'
	RACE_COLLECTION = 'racers'

	def self.mongo_client
		database = MONGO_DATABASE
    db = Mongo::Client.new(MONGO_URL)
    db.use(database)
  end

  def self.collection
    self.mongo_client[RACE_COLLECTION]
  end
  
#   # def self.load_hash(file_path) 
#   #   file=File.read(file_path)
#   #   JSON.parse(file)
#   # end
  
#   # def initialize
#   #   @coll = self.class.collection
#   # end

end