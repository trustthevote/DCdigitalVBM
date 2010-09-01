class AddAttestationFieldsToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :attestation_file_name, :string
    add_column :registrations, :attestation_file_size, :integer
    add_column :registrations, :attestation_content_type, :string
    add_column :registrations, :attestation_updated_at, :datetime
  end

  def self.down
    remove_column :registrations, :attestation_updated_at
    remove_column :registrations, :attestation_content_type
    remove_column :registrations, :attestation_file_size
    remove_column :registrations, :attestation_file_name
  end
end
