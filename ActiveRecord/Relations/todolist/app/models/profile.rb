class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_or_last_name_exists
  validates :gender, format: {with: /(fe)?male/}
  validate :no_Sue_males

  def first_or_last_name_exists
    if !first_name && !last_name
      errors.add(:first_name, "First or Last Name should be specified!");
      errors.add(:last_name, "First or Last Name should be specified!");
    end
  end

  def no_Sue_males
    if first_name && first_name == "Sue"
      errors.add(:first_name, "First Name for male can't be Sue!");
    end
  end
end
