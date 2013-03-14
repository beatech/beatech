class ChangePageTextMax < ActiveRecord::Migration
  def up
    change_column(:pages, :text, :text, :limit => 21844)
  end

  def down
    change_column(:pages, :text, :string, :limit => 255)
  end
end
