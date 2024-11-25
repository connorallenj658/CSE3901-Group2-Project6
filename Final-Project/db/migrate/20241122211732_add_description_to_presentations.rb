class AddDescriptionToPresentations < ActiveRecord::Migration[7.2]
  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "credits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end  
end
