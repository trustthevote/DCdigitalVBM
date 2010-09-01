class CreatePrecinctSplits < ActiveRecord::Migration
  def self.up
    create_table :precinct_splits do |t|
      t.integer :precinct_id
      t.string  :name
    end
    
    add_index :precinct_splits, :precinct_id
  end

  def self.down
    drop_table :precinct_splits
  end
end
