class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates_presence_of :content
  has_many :collects
  has_many :collected_users, through: :collects, source: :user
end
