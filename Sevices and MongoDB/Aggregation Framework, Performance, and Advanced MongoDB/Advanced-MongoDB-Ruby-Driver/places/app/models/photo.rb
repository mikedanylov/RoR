require 'pp'

class Photo
  include Mongoid::Document

  attr_accessor :id, :location, :contents

	RACE_COLLECTION='race1'
	
	def self.mongo_client
		Mongoid::Clients.default
	end

	def initialize(params=nil)
		@id = params[:_id].to_s if !params.nil? && !params[:_id].nil?
		@location = Point.new(params[:metadata][:location]) if !params.nil? && !params[:metadata].nil?
		@place = params[:metadata][:place] if !params.nil? && !params[:metadata].nil?
	end

	def persisted?
		!@id.nil?
	end

	def save
		if @place.is_a? Place
			@place = BSON::ObjectId.from_string(@place.id)
		end

		if !persisted?
			gps = EXIFR::JPEG.new(@contents).gps
			location=Point.new(lng: gps.longitude, lat: gps.latitude)
			@contents.rewind

			description={}
			description[:metadata] = {
				:location => location.to_hash,
				:place => @place
			}

			description[:content_type] = "image/jpeg"
			@location = Point.new(location.to_hash)
			grid_file = Mongo::Grid::File.new(@contents.read, description)
			@id = self.class.mongo_client.database.fs.insert_one(grid_file).to_s
		else
			doc = self.class.mongo_client.database.fs.find(
			'_id': BSON::ObjectId.from_string(@id)
			).first
			doc[:metadata][:place] = @place
			doc[:metadata][:location] = @location.to_hash
			self.class.mongo_client.database.fs.find(
			'_id': BSON::ObjectId.from_string(@id)
			).update_one(doc)
		end
	end

end
