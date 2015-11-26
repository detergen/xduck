# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151101103306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "parent_id"
    t.integer  "activity_type_id"
    t.string   "number"
    t.integer  "from_organization_id"
    t.integer  "to_organization_id"
    t.date     "date"
    t.integer  "owner_user_id"
    t.decimal  "total"
    t.string   "note"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "sum_koef"
    t.decimal  "price"
    t.string   "group_name"
    t.string   "sort_name"
    t.integer  "activity_status_id"
    t.integer  "to_bankacc_id"
    t.integer  "from_bankacc_id"
  end

  create_table "activity_items", force: true do |t|
    t.integer  "activity_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
  end

  create_table "activity_statuses", force: true do |t|
    t.string "name"
  end

  create_table "activity_types", force: true do |t|
    t.string "name"
  end

  create_table "addrs", force: true do |t|
    t.string   "name"
    t.string   "typeofaddr"
    t.string   "postindex"
    t.string   "string1"
    t.string   "string2"
    t.string   "address_key"
    t.text     "note"
    t.integer  "organization_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bankaccs", force: true do |t|
    t.string   "name"
    t.string   "full_name"
    t.string   "ks"
    t.string   "rs"
    t.string   "bik"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boms", force: true do |t|
    t.integer  "product_id"
    t.integer  "subproduct_id"
    t.integer  "group_id"
    t.decimal  "qty"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "full_name"
    t.string   "to_name"
    t.string   "post"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "phone4"
    t.string   "contact_key"
    t.string   "tag"
    t.text     "note"
    t.string   "pasp_series"
    t.string   "pasp_number"
    t.string   "pasp_date"
    t.string   "pasp_given"
    t.string   "pasp_kp"
    t.string   "address"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string "code"
  end

  add_index "currencies", ["code"], name: "index_currencies_on_code", unique: true, using: :btree

  create_table "exchange_rates", force: true do |t|
    t.integer  "from_currency_id",                          null: false
    t.integer  "to_currency_id",                            null: false
    t.decimal  "exchange_rate",    precision: 10, scale: 4
    t.datetime "from_date"
    t.datetime "to_date"
  end

  create_table "old_products", id: false, force: true do |t|
    t.integer  "id"
    t.string   "name"
    t.string   "articul"
    t.boolean  "active"
    t.boolean  "forsale"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sizes",                limit: 30
    t.integer  "purchase_currency_id"
    t.decimal  "purchase_price",                  precision: 10, scale: 2
    t.integer  "sale_currency_id"
    t.decimal  "sale_price",                      precision: 10, scale: 2
    t.string   "measure"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "tag"
    t.string   "opf"
    t.string   "short_name"
    t.string   "full_name"
    t.string   "inn"
    t.string   "kpp"
    t.string   "ogrn"
    t.string   "okpo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "organization_id"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "articul"
    t.boolean  "active"
    t.boolean  "forsale"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sizes",                limit: 30
    t.integer  "purchase_currency_id"
    t.decimal  "purchase_price",                  precision: 10, scale: 2
    t.integer  "sale_currency_id"
    t.decimal  "sale_price",                      precision: 10, scale: 2
    t.string   "measure"
  end

  add_index "products", ["articul"], name: "idx_prodcuts_articul", unique: true, using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "totals", force: true do |t|
    t.string  "name"
    t.string  "expression"
    t.boolean "is_active"
    t.string  "note"
    t.integer "sort_order"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
