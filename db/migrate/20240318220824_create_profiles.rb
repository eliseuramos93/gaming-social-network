class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.date :birth_date
      t.string :full_name
      t.text :bio
      t.string :country

      t.timestamps
    end
  end
end
