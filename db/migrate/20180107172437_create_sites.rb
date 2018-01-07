class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :url, null: false
      t.integer :protocol, null: false, default: 0
      t.string :hostname, null: false
      t.integer :bookmarks_count

      t.timestamps
    end
  end
end
