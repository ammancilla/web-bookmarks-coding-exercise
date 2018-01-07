class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.references :site, foreign_key: true, index: true, null: false
      t.text :url, null: false

      t.timestamps
    end
  end
end
