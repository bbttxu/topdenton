class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.integer :position
      t.datetime :plays_at
      t.integer :band_id
      t.integer :show_id
      
      t.timestamps
    end
  end
end
