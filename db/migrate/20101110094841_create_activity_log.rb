class CreateActivityLog < ActiveRecord::Migration
  def self.up
    create_table :activity_log do |t|
      t.integer :registration_id
      t.string  :type
      t.string  :voting_type
      t.text    :data

      t.timestamps
    end
    add_index :activity_log, :registration_id
  end

  def self.down
    drop_table :activity_log
  end
end
