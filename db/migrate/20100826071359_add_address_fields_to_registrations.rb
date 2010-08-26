class AddAddressFieldsToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :address, :string
    add_column :registrations, :city, :string
    add_column :registrations, :state, :string
  end

  def self.down
    remove_column :registrations, :state
    remove_column :registrations, :city
    remove_column :registrations, :address
  end
end
