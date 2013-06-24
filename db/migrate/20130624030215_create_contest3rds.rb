class CreateContest3rds < ActiveRecord::Migration
  def change
    create_table :contest3rds do |t|
      t.integer :a_score
      t.integer :a_clear
      t.integer :b_score
      t.integer :b_clear
      t.integer :c_score
      t.integer :c_clear
      t.string :name
      t.string :music
      t.integer :order
      t.string :team
      t.string :movie_url

      t.timestamps
    end
  end
end
