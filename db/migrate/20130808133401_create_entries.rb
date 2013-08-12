class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :url
      t.integer :menu
      t.text :text
      t.integer :type

      t.timestamps
    end
  end
end
