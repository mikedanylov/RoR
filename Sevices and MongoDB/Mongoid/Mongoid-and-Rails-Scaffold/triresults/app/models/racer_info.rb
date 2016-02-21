class RacerInfo
	include Mongoid::Document
	field :first_name, as: :fn, type: String
	field :last_name, as: :ln, type: String
	field :gender, as: :g, type: String
	field :birth_year, as: :yr, type: Integer
	field :residence, as: :res, type: Address
	field :racer_id, as: :_id
	field :_id, default:->{ racer_id }
end
