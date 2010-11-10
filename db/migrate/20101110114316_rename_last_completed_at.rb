class RenameLastCompletedAt < ActiveRecord::Migration
  def self.up
    rename_column :registrations, :last_completed_at, :completed_at
  end

  def self.down
    rename_column :registrations, :completed_at, :last_completed_at
  end
end
