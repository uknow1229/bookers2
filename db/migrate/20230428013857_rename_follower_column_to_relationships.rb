class RenameFollowerColumnToRelationships < ActiveRecord::Migration[6.1]
  def change
    rename_column :relationships, :folower, :follower
  end
end
