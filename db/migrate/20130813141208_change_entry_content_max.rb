class ChangeEntryContentMax < ActiveRecord::Migration
  def up
    change_column(:entries, :content, :text, :limit => 21844)
  end

  def down
    change_column(:entries, :content, :text, :limit => 255)
  end
end
