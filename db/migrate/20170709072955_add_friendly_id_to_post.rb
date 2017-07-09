class AddFriendlyIdToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :friendly_id, :string
    add_index :posts, :friendly_id, :unique => true

    Post.find_each do |p|
      p.update( :friendly_id => SecureRandom.uuid )
    end
  end
end
