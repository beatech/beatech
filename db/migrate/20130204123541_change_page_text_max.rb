class ChangePageTextMax < ActiveRecord::Migration
  def up
    change_column(:pages, :text, :string, :limit => 30000)
  end

  def down
    change_column(:pages, :text, :string, :limit => 255)
  end
end
