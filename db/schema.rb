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

ActiveRecord::Schema.define(version: 20140807192053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: true do |t|
    t.string   "fullname",                          null: false
    t.string   "email",                             null: false
    t.string   "phone",                             null: false
    t.text     "special_requirements", default: ""
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "time_slots", force: true do |t|
    t.datetime "started_at", null: false
    t.integer  "booking_id"
    t.string   "email"
  end

  add_index "time_slots", ["booking_id"], name: "index_time_slots_on_booking_id", using: :btree
  add_index "time_slots", ["started_at"], name: "index_time_slots_on_started_at", using: :btree

end
