class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end

  has_many :posts
  has_many :collects
  has_many :collected_posts, through: :collects, source: :post

  def is_collect_of?(post)
    collected_posts.include?(post)
  end

  has_many :likes, :dependent => :destroy
  has_many :liked_posts, through: :likes, source: :post

  def display_name
    self.email.split("@").first
  end

end
