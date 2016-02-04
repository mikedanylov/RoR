class Point
	include Mongoid::Document
	attr_accessor :longitude, :latitude

	def initialize hash
		@longitude = hash[:lng] || hash[:coordinates][0]
		@latitude = hash[:lat] || hash[:coordinates][1]
	end

	def to_hash
		{ "type": "Point", "coordinates":[ @longitude, @latitude] }
	end

end

