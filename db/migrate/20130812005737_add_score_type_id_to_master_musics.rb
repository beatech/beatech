class AddScoreTypeIdToMasterMusics < ActiveRecord::Migration
  def change
    add_reference :master_musics, :score_type, index: true
  end
end
