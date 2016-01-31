class AddressComponent
	include Mongoid::Document
	attr_reader :long_name, :short_name, :types

	def initialize hash
		@long_name = hash[:long_name] if hash.key?(:long_name)
		@short_name = hash[:short_name] if hash.key?(:short_name)
		@types = hash[:types] if hash.key?(:types)
	end

end
