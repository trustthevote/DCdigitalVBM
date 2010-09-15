class CreateFlowCompletions < ActiveRecord::Migration
  def self.up
    create_table :flow_completions do |t|
      t.integer :registration_id
      t.string  :voting_type

      t.timestamps
    end
    
    add_index :flow_completions, :registration_id
  end

  def self.down
    drop_table :flow_completions
  end
end
