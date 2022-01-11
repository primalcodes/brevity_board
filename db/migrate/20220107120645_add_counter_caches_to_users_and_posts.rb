class AddCounterCachesToUsersAndPosts < ActiveRecord::Migration[6.1]
  def up
    add_column(:users, :comments_count, :integer, null: false, default: 0)
    add_column(:users, :posts_count, :integer, null: false, default: 0)
    add_column(:posts, :comments_count, :integer, null: false, default: 0)
  end

  def down
    remove_column(:users, :comments_count)
    remove_column(:users, :posts_count)
    remove_column(:posts, :comments_count)
  end
end
