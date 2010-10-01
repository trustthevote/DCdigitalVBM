class DropStatusChanges < ActiveRecord::Migration
  def self.up
    drop_table :status_changes
  end

  def self.down
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
  end
end
