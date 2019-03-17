class AddColumnsToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :album_id, :integer, null: false
    add_column :tracks, :title, :string, null: false
    add_column :tracks, :ord, :integer, null: false
    add_column :tracks, :lyrics, :text
    add_column :tracks, :type_track, :string, null: false, default: "regular"
    add_index :tracks, :album_id
  end
end
