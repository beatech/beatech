class CreateMenus < ActiveRecord::Migration
  def up
    create_table :menus do |t|
      t.string :title
      t.string :section
      t.integer :position

      t.timestamps
    end

    Menu.reset_column_information
    menus = [
      { title: "サークルメニュー", section: "side",   position: 1 },
      { title: "交流メニュー",     section: "side",   position: 2 },
      { title: "音ゲーコンテンツ", section: "side",   position: 3 },
      { title: "非部員向けページ", section: "header", position: 1 },
    ]
    menus.each do |menu|
      Menu.create(menu)
    end

    rename_column :entries, :menu, :menu_id
    Entry.reset_column_information
    Entry.all.each do |entry|
      entry.update!(menu_id: nil) if entry.menu_id == 0
    end
  end

  def down
    drop_table :menus
    rename_column :entries, :menu_id, :menu
    Entry.reset_column_information
    Entry.all.each do |entry|
      entry.update!(menu: 0) if entry.menu == nil
    end
  end
end
