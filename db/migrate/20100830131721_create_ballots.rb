class CreateBallots < ActiveRecord::Migration
  def self.up
    create_table :ballots do |t|
      t.integer   :registration_id

      t.string    :pdf_file_name
      t.string    :pdf_content_type
      t.integer   :pdf_file_size
      t.datetime  :pdf_updated_at
    end
    
    add_index :ballots, :registration_id, :unique => true
  end

  def self.down
    drop_table :ballots
  end
end
