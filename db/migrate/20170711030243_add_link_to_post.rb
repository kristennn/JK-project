class AddLinkToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :link, :string
  end
end
