class AddMetacontentToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :metacontent, :text
  end
end
