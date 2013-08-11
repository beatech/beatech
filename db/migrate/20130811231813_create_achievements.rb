class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.date :date
      t.text :text
      t.references :user, index: true

      t.timestamps
    end
  end
end
