class AddReviewerIdToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :reviewer_id, :integer
    add_index :registrations, :reviewer_id
  end

  def self.down
    remove_index :registrations, :reviewer_id
    remove_column :registrations, :reviewer_id
  end
end
