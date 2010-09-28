class AddLastReviewedAtToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :last_reviewed_at, :datetime
  end

  def self.down
    remove_column :registrations, :last_reviewed_at
  end
end
