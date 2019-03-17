class ChangeColumnNameInAlbums < ActiveRecord::Migration[5.2]
  def change
    rename_column :albums, :type, :kind
  end
end
