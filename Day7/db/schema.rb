# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_07_053044) do

  create_table "container_rules", force: :cascade do |t|
    t.integer "container_id", null: false
    t.integer "rule_id", null: false
    t.integer "count", null: false
    t.index ["container_id"], name: "index_container_rules_on_container_id"
    t.index ["rule_id"], name: "index_container_rules_on_rule_id"
  end

  create_table "containers", force: :cascade do |t|
    t.string "color"
  end

  create_table "rules", force: :cascade do |t|
    t.integer "container_id", null: false
    t.index ["container_id"], name: "index_rules_on_container_id"
  end

  add_foreign_key "container_rules", "containers"
  add_foreign_key "container_rules", "rules"
  add_foreign_key "rules", "containers"
end