class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates_presence_of :content
  before_validation :generate_friendly_id, on: :create

  def to_param
    self.friendly_id
  end

  belongs_to :user

  has_many :collects
  has_many :collected_users, through: :collects, source: :user
  has_many :comments

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  def find_like(user)
    self.likes.where( :user_id => user.id).first
  end

  has_many :hates
  has_many :hated_users, through: :hates, source: :user

  def find_hate(user)
    self.hates.where( :user_id => user.id ).first
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  def public!
    self.is_hidden = false
    self.save
  end

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end

end
