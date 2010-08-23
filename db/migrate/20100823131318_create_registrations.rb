class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.string :name
      t.string :pin

      t.timestamps
    end
    
    add_index :registrations, [ :pin, :name ], :unique => true
  end

  def self.down
    drop_table :registrations
  end
end
