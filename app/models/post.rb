class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates_presence_of :content

  has_many :collects
  has_many :collected_users, through: :collects, source: :user

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  def find_like(user)
    self.likes.where( :user_id => user.id).first
  end

  
end
