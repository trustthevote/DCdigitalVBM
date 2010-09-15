class AddCheckedInAtToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :checked_in_at, :datetime
  end

  def self.down
    remove_column :registrations, :checked_in_at
  end
end
