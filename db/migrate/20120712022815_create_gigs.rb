class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.integer :position
      t.datetime :plays_at

      t.timestamps
    end
  end
end
