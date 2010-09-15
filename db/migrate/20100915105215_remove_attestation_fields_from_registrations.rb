class RemoveAttestationFieldsFromRegistrations < ActiveRecord::Migration
  def self.up
    remove_column :registrations, :attestation_file_name
    remove_column :registrations, :attestation_file_size
    remove_column :registrations, :attestation_content_type
    remove_column :registrations, :attestation_updated_at
  end

  def self.down
    add_column :registrations, :attestation_updated_at, :datetime
    add_column :registrations, :attestation_content_type, :string
    add_column :registrations, :attestation_file_size, :integer
    add_column :registrations, :attestation_file_name, :string
  end
end
