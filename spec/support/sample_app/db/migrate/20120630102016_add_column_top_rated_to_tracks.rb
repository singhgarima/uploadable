class AddColumnTopRatedToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :top_rated, :boolean
  end
end
