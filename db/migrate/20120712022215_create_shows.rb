class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.datetime :doors_at
      t.string :price
      t.string :source
      t.datetime :starts_at
      t.string :admittance
      t.integer :venue_id

      t.timestamps
    end
  end
end
