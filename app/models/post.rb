class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates_presence_of :content
end
