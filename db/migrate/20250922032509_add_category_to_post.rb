class AddCategoryToPost < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :category, :string
    add_column :posts, :string, :string
  end
end
