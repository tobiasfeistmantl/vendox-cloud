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

ActiveRecord::Schema.define(version: 20150428063454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street"
    t.string   "zip_code"
    t.string   "locality"
    t.integer  "costs_per_product_in_cent"
    t.string   "phone_number"
    t.string   "slug"
    t.integer  "remaining_products",        default: 10
  end

  add_index "companies", ["confirmation_token"], name: "index_companies_on_confirmation_token", unique: true, using: :btree
  add_index "companies", ["email"], name: "index_companies_on_email", unique: true, using: :btree
  add_index "companies", ["name"], name: "index_companies_on_name", using: :btree
  add_index "companies", ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true, using: :btree
  add_index "companies", ["slug"], name: "index_companies_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price_in_cent"
    t.integer  "company_id"
    t.integer  "status",          default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "longitude"
    t.float    "latitude"
    t.string   "product_picture"
    t.string   "order_link"
    t.text     "description"
    t.integer  "count",           default: 0
    t.integer  "category_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree
  add_index "products", ["name"], name: "index_products_on_name", using: :btree

  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
end
