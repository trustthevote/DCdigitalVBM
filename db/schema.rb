# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100826071359) do

  create_table "registrations", :force => true do |t|
    t.string   "name"
    t.string   "zip"
    t.string   "pin_hash"
    t.string   "voter_id"
    t.integer  "precinct_split_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "city"
    t.string   "state"
  end

  add_index "registrations", ["pin_hash", "voter_id", "name", "zip"], :name => "index_registrations_on_pin_hash_and_voter_id_and_name_and_zip", :unique => true
  add_index "registrations", ["precinct_split_id"], :name => "index_registrations_on_precinct_split_id"

end
