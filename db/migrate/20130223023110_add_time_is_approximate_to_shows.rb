class AddTimeIsApproximateToShows < ActiveRecord::Migration
  def change
  	add_column :shows, :time_is_unknown, :boolean
  end
end
