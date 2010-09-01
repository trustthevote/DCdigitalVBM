class CreateBallotStyles < ActiveRecord::Migration
  def self.up
    create_table :ballot_styles do |t|
      t.integer   :precinct_split_id, :null => false

      t.string    :pdf_file_name
      t.string    :pdf_content_type
      t.integer   :pdf_file_size
      t.datetime  :pdf_updated_at
    end
    
    add_index :ballot_styles, :precinct_split_id, :unique => true
  end

  def self.down
    drop_table :ballot_styles
  end
end
