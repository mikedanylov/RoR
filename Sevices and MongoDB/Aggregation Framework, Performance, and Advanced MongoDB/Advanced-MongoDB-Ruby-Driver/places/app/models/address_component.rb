class AddressComponent
	include Mongoid::Document
	attr_reader :long_name, :short_name, :types

	def initialize hash
		@long_name = hash[:long_name] if hash[:long_name]
		@short_name = hash[:short_name] if hash[:short_name]
		@types = hash[:types] if hash[:types]
	end

end
