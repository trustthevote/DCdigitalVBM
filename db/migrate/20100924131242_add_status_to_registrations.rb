class AddStatusToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :status, :string
    add_column :registrations, :deny_comment, :text
  end

  def self.down
    remove_column :registrations, :deny_comment
    remove_column :registrations, :status
  end
end
