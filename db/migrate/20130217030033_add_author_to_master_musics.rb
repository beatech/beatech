class AddAuthorToMasterMusics < ActiveRecord::Migration
  def change
    add_column :master_musics, :author, :string
  end
end
