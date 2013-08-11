class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.integer :year
      t.integer :repeated_year
      t.text :bio
      t.text :profile
      t.string :profile_image

      t.timestamps
    end
  end
end
