class AddLastCompletedAtToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :last_completed_at, :datetime
  end

  def self.down
    remove_column :registrations, :last_completed_at
  end
end
