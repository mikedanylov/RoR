class BirthdayStringToInt < ActiveRecord::Migration
  def change
    remove_column :profiles, :birth_year
    add_column :profiles, :birth_year, :integer
  end
end
