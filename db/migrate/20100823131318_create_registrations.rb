class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.string  :name
      t.string  :zip
      t.string  :pin_hash
      t.string  :voter_id

      t.integer :precinct_split_id

      t.timestamps
    end
    
    add_index :registrations, [ :pin_hash, :voter_id, :name, :zip ], :unique => true
    add_index :registrations, :precinct_split_id
  end

  def self.down
    drop_table :registrations
  end
end
