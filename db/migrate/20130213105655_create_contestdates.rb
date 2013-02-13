class CreateContestdates < ActiveRecord::Migration
  def change
    create_table :contestdates do |t|
      t.integer :order
      t.string :place

      t.timestamps
    end
  end
end
