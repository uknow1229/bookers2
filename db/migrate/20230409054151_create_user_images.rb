class CreateUserImages < ActiveRecord::Migration[6.1]
  def change
    create_table :user_images do |t|
      t.string :name
      t.string :title
      t.string :body
      t.integer :user_id

      t.timestamps
    end
  end
end
