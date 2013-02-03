class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :url
      t.integer :menu
      t.integer :limit
      t.string :text

      t.timestamps
    end
  end
end
