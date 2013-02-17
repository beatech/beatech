class AddUrlToMasterMusics < ActiveRecord::Migration
  def change
    add_column :master_musics, :url, :string
  end
end
