class RenameDenyCommentToDenyReason < ActiveRecord::Migration
  def self.up
    rename_column :registrations, :deny_comment, :deny_reason
  end

  def self.down
    rename_column :registrations, :deny_reason, :deny_comment
  end
end
