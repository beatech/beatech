class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.string :year
      t.string :repeated_year
      t.string :grade
      t.string :bio
      t.string :profile
      t.string :icon_url

      t.timestamps
    end
  end
end
