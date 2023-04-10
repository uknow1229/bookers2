class RemoveNameFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :name, :integer
  end
end
