class DropFlowCompletions < ActiveRecord::Migration
  def self.up
    drop_table :flow_completions
  end

  def self.down
    create_table "flow_completions", :force => true do |t|
      t.integer  "registration_id"
      t.string   "voting_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_index "flow_completions", ["registration_id"], :name => "index_flow_completions_on_registration_id"
  end
end
