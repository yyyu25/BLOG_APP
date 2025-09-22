class RemoveStringFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :string, :string
  end
end
