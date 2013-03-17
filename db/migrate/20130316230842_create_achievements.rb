class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :user_id
      t.date :date
      t.text :text

      t.timestamps
    end
  end
end
