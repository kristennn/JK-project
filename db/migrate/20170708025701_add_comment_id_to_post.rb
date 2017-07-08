class AddCommentIdToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :comment_id, :integer
  end
end
