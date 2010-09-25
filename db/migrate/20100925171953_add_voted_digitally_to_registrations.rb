class AddVotedDigitallyToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :voted_digitally, :boolean, :default => false
    add_index :registrations, :voted_digitally
  end

  def self.down
    remove_index :registrations, :voted_digitally
    remove_column :registrations, :voted_digitally
  end
end
