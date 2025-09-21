class FixLikesCountOnPosts < ActiveRecord::Migration[7.1]
  def up
    # 先把已有的 NULL 都改为 0
    execute "UPDATE posts SET likes_count = 0 WHERE likes_count IS NULL"

    # 设默认值并禁止为 NULL
    change_column_default :posts, :likes_count, 0
    change_column_null    :posts, :likes_count, false
  end

  def down
    change_column_null    :posts, :likes_count, true
    change_column_default :posts, :likes_count, nil
  end
end