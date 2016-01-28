
require 'pp'
require 'json'
require 'mongo'

class Racer
	include ActiveModel::Model
	attr_accessor :id, :number, :first_name, :last_name, :gender, :group, :secs

	MONGO_URL = 'mongodb://localhost:27017'
	MONGO_DATABASE = 'raceday_development'
	RACE_COLLECTION = 'racers'

	def self.mongo_client
		url=ENV['MONGO_URL'] ||= MONGO_URL
    database=ENV['MONGO_DATABASE'] ||= MONGO_DATABASE 
    db = Mongo::Client.new(url)
    @@db=db.use(database)
	end

	def self.collection
		collection=ENV['RACE_COLLECTION'] ||= RACE_COLLECTION
		return mongo_client[collection]
	end
	
	def self.all(prototype={}, sort={number:1}, skip=0, limit=nil) 
		return self.collection
								.find(prototype)
								.sort(sort)
								.skip(skip) if limit == nil
		self.collection
				.find(prototype)
				.sort(sort)
				.skip(skip)
				.limit(limit)
	end

	def initialize(params={})
		@id=params[:_id].nil? ? params[:id] : params[:_id].to_s
		@number=params[:number].to_i
		@first_name=params[:first_name]
		@last_name=params[:last_name]
		@gender=params[:gender]
		@group=params[:group]
		@secs=params[:secs].to_i
	end

	def self.find id
		racer = self.collection
								.find( { _id: BSON::ObjectId.from_string(id) } )
								.first
		return racer.nil? ? nil : Racer.new(racer)
	end

	def save
		result = Racer.collection.insert_one({
			first_name: @first_name,
			last_name: 	@last_name,
			number: 		@number,
			gender: 		@gender,
			group: 			@group,
			secs: 			@secs
		})

		if result.n == 1
			@id = Racer.collection
									.find( { number: @number } )
									.first[:_id] 
		end
	end

	def update(params)
	  @number = params[:number].to_i
	  @first_name = params[:first_name] 
	  @last_name = params[:last_name]  
	  @secs = params[:secs].to_i
	  @group=params[:group]
	  @gender=params[:gender]

	  params.slice!(:number, :first_name, :last_name, :gender, :group, :secs) if !params.nil?
	  Racer.collection
	  			.find(_id: BSON::ObjectId.from_string(@id))
	  			.replace_one(params)
	end

	def destroy
	  Racer.collection
	  			.find(number: @number)
	  			.delete_one
	end

	def persisted?
	  !@id.nil?
	end

	def created_at
	  nil
	end
	
	def updated_at
	  nil
	end

end
