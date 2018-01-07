ActiveRecord::Schema.define(version: 20180107182215) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer "site_id", null: false
    t.text "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_bookmarks_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "url", null: false
    t.integer "protocol", default: 0, null: false
    t.string "hostname", null: false
    t.integer "bookmarks_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
