class Point
	include Mongoid::Document
	attr_accessor :longitude, :latitude

	def initialize hash
		if hash.key?(:lat) and hash.key?(:lng)
			@longitude = hash[:lng]
			@latitude = hash[:lat]
		elsif hash.key?(:type) and hash.key?(:coordinates)
			@longitude = hash[:coordinates][0]
			@latitude = hash[:coordinates][1]
		end
	end

	def to_hash
		{ "type": "Point", "coordinates":[ @longitude, @latitude] }
	end

end

