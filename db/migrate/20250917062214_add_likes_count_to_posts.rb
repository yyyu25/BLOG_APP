class AddLikesCountToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :likes_count, :integer
  end
end
