
require 'pp'

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
    @coll = self.mongo_client[RACE_COLLECTION]
  end
  
  def self.all(prototype={}, sort={number:1}, skip=0, limit=nil) 
  	return @coll.find(prototype).sort(sort).skip(skip) if limit == nil
  	@coll.find(prototype).sort(sort).skip(skip).limit(limit)
	end

end

racers = Racer.collection