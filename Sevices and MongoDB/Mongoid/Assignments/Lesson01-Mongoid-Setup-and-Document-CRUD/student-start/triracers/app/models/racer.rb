class Racer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :dob, as: :date_of_birth, type: Date
  field :gender, type: String
end
