class CreateContestdate3rds < ActiveRecord::Migration
  def change
    create_table :contestdate3rds do |t|
      t.integer :order
      t.string :place

      t.timestamps
    end
  end
end
