# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171008185312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace", limit: 255
    t.text "body"
    t.string "resource_id", limit: 255, null: false
    t.string "resource_type", limit: 255, null: false
    t.integer "author_id"
    t.string "author_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "activities", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.integer "activity_type_id"
    t.string "number", limit: 255
    t.integer "from_organization_id"
    t.integer "to_organization_id"
    t.date "date"
    t.integer "owner_user_id"
    t.decimal "total"
    t.string "note", limit: 255
    t.string "tag", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "type", limit: 255
    t.integer "sum_koef"
    t.decimal "price"
    t.string "group_name", limit: 255
    t.string "sort_name", limit: 255
    t.integer "activity_status_id"
    t.integer "to_bankacc_id"
    t.integer "from_bankacc_id"
  end

  create_table "activity_items", id: :serial, force: :cascade do |t|
    t.integer "activity_id"
    t.integer "product_id"
    t.integer "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "price"
  end

  create_table "activity_statuses", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "activity_statuses_relations", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "activity_status_id"
    t.datetime "created_at"
    t.index ["activity_id"], name: "index_activity_statuses_relations_on_activity_id"
    t.index ["activity_status_id"], name: "index_activity_statuses_relations_on_activity_status_id"
  end

  create_table "activity_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "addrs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "typeofaddr", limit: 255
    t.string "postindex", limit: 255
    t.string "string1", limit: 255
    t.string "string2", limit: 255
    t.string "address_key", limit: 255
    t.text "note"
    t.integer "organization_id"
    t.integer "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bankaccs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "full_name", limit: 255
    t.string "ks", limit: 255
    t.string "rs", limit: 255
    t.string "bik", limit: 255
    t.integer "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sort_order"
  end

  create_table "boms", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "subproduct_id"
    t.integer "group_id"
    t.decimal "qty"
    t.boolean "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "short_name", limit: 255
    t.string "full_name", limit: 255
    t.string "to_name", limit: 255
    t.string "post", limit: 255
    t.string "phone1", limit: 255
    t.string "phone2", limit: 255
    t.string "phone3", limit: 255
    t.string "phone4", limit: 255
    t.string "contact_key", limit: 255
    t.string "tag", limit: 255
    t.text "note"
    t.string "pasp_series", limit: 255
    t.string "pasp_number", limit: 255
    t.string "pasp_date", limit: 255
    t.string "pasp_given", limit: 255
    t.string "pasp_kp", limit: 255
    t.string "address", limit: 255
    t.integer "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255
    t.index ["code"], name: "index_currencies_on_code", unique: true
  end

  create_table "exchange_rates", id: :serial, force: :cascade do |t|
    t.integer "from_currency_id", null: false
    t.integer "to_currency_id", null: false
    t.decimal "exchange_rate", precision: 10, scale: 4
    t.datetime "from_date"
    t.datetime "to_date"
  end

  create_table "old_products", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "name", limit: 255
    t.string "articul", limit: 255
    t.boolean "active"
    t.boolean "forsale"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sizes", limit: 30
    t.integer "purchase_currency_id"
    t.decimal "purchase_price", precision: 10, scale: 2
    t.integer "sale_currency_id"
    t.decimal "sale_price", precision: 10, scale: 2
    t.string "measure", limit: 255
  end

  create_table "organizations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "tag", limit: 255
    t.string "opf", limit: 255
    t.string "short_name", limit: 255
    t.string "full_name", limit: 255
    t.string "inn", limit: 255
    t.string "kpp", limit: 255
    t.string "ogrn", limit: 255
    t.string "okpo", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "organization_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "articul", limit: 255
    t.boolean "active"
    t.boolean "forsale"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sizes", limit: 30
    t.integer "purchase_currency_id"
    t.decimal "purchase_price", precision: 10, scale: 2
    t.integer "sale_currency_id"
    t.decimal "sale_price", precision: 10, scale: 2
    t.string "measure", limit: 255
    t.index ["articul"], name: "idx_prodcuts_articul", unique: true
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "resource_id"
    t.string "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "totals", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "expression", limit: 255
    t.boolean "is_active"
    t.string "note", limit: 255
    t.integer "sort_order"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

end
