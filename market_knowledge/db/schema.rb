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

ActiveRecord::Schema.define(version: 3) do

  create_table "leases", force: :cascade do |t|
    t.string "tenant"
    t.integer "lease_size"
    t.string "suite"
    t.integer "term"
    t.date "sign_date"
    t.date "commencement_date"
    t.date "expiration_date"
    t.string "lease_type"
    t.integer "fy_rent"
    t.string "rent_type"
    t.integer "effective_rent"
    t.string "escalation"
    t.integer "free_rent"
    t.integer "ti_psf"
    t.string "transaction_type"
    t.string "tenant_broker_company"
    t.string "base_year"
    t.string "landlord_broker_company"
    t.string "bldg_owner"
    t.string "property_manager"
    t.integer "quoted_rate"
    t.integer "nnn"
    t.integer "electric"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string "property_name"
    t.string "street"
    t.string "city"
    t.integer "year_built"
    t.integer "remodel_year"
    t.integer "gross_bldg_area"
    t.integer "foundation_area"
    t.integer "num_stories"
    t.integer "net_lease_area"
    t.string "bldg_class"
    t.string "business_park"
    t.string "submarket"
    t.string "landlord_broker_company"
    t.string "bldg_owner"
    t.string "property_manager"
    t.integer "quoted_rate"
    t.integer "nnn"
    t.integer "electric"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
