class UpdateRegistrationFields < ActiveRecord::Migration
  def self.up
    remove_index  :registrations, :column => [ :name, :zip ]

    remove_column :registrations, :name
    remove_column :registrations, :city
    remove_column :registrations, :state
    add_column    :registrations, :ssn4,        :string
    add_column    :registrations, :first_name,  :string
    add_column    :registrations, :middle_name, :string
    add_column    :registrations, :last_name,   :string
  end

  def self.down
    remove_column :registrations, :last_name
    remove_column :registrations, :middle_name
    remove_column :registrations, :first_name
    remove_column :registrations, :ssn4
    add_column    :registrations, :state, :string
    add_column    :registrations, :city, :string
    add_column    :registrations, :name, :string

    add_index     :registrations, [ :name, :zip ], :unique => true
  end
end
