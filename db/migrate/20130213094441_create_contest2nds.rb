class CreateContest2nds < ActiveRecord::Migration
  def change
    create_table :contest2nds do |t|
      t.string :name
      t.string :team
      t.integer :order
      t.integer :a_score
      t.integer :a_bp
      t.integer :b_score
      t.integer :b_bp
      t.integer :c_score
      t.integer :c_bp
      t.string :music
      t.integer :notes

      t.timestamps
    end
  end
end
