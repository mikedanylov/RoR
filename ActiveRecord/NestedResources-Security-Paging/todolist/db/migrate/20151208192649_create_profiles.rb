class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :gender
      t.string :birth_year
      t.string :first_name
      t.string :last_name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
