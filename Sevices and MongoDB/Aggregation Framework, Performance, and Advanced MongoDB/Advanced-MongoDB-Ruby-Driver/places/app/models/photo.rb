require 'pp'

class Photo
  include Mongoid::Document

  attr_accessor :id, :location, :contents

	RACE_COLLECTION='race1'
	
	def self.mongo_client
		Mongoid::Clients.default
	end

	def initialize params
		@id = params[:_id].to_s if params.key?(:_id)
		if params.key?(:metadata)
			if params[:metadata].key?(:location)
				@location = Point.new(params[:metadata][:location])
			end
		end
	end

end
