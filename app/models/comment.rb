class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def hide!
    self.is_hidden = true
    self.save
  end

  def public!
    self.is_hidden = false
    self.save
  end

end
