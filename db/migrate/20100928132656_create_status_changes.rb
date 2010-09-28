class CreateStatusChanges < ActiveRecord::Migration
  def self.up
    create_table :status_changes do |t|
      t.integer :registration_id, :null => false
      t.integer :reviewer_id,     :null => false
      t.string  :status
      t.string  :deny_reason

      t.timestamps
    end
    
    add_index :status_changes, :registration_id
    add_index :status_changes, :reviewer_id
  end

  def self.down
    drop_table :status_changes
  end
end
