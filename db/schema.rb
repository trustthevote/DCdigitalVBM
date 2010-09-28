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

ActiveRecord::Schema.define(:version => 20100928160047) do

  create_table "ballot_styles", :force => true do |t|
    t.integer  "precinct_split_id", :null => false
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  add_index "ballot_styles", ["precinct_split_id"], :name => "index_ballot_styles_on_precinct_split_id", :unique => true

  create_table "ballots", :force => true do |t|
    t.integer  "registration_id"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  add_index "ballots", ["registration_id"], :name => "index_ballots_on_registration_id", :unique => true

  create_table "flow_completions", :force => true do |t|
    t.integer  "registration_id"
    t.string   "voting_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flow_completions", ["registration_id"], :name => "index_flow_completions_on_registration_id"

  create_table "precinct_splits", :force => true do |t|
    t.integer "precinct_id"
    t.string  "name"
  end

  add_index "precinct_splits", ["precinct_id"], :name => "index_precinct_splits_on_precinct_id"

  create_table "precincts", :force => true do |t|
    t.string "name"
  end

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
    t.datetime "checked_in_at"
    t.datetime "last_completed_at"
    t.string   "status"
    t.text     "deny_reason"
    t.boolean  "voted_digitally",   :default => false
    t.integer  "reviewer_id"
    t.datetime "last_reviewed_at"
  end

  add_index "registrations", ["pin_hash", "voter_id", "name", "zip"], :name => "index_registrations_on_pin_hash_and_voter_id_and_name_and_zip", :unique => true
  add_index "registrations", ["precinct_split_id"], :name => "index_registrations_on_precinct_split_id"
  add_index "registrations", ["reviewer_id"], :name => "index_registrations_on_reviewer_id"
  add_index "registrations", ["voted_digitally"], :name => "index_registrations_on_voted_digitally"

  create_table "status_changes", :force => true do |t|
    t.integer  "registration_id", :null => false
    t.integer  "reviewer_id",     :null => false
    t.string   "status"
    t.string   "deny_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "status_changes", ["registration_id"], :name => "index_status_changes_on_registration_id"
  add_index "status_changes", ["reviewer_id"], :name => "index_status_changes_on_reviewer_id"

  create_table "users", :force => true do |t|
    t.string   "login",                             :null => false
    t.string   "email",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
