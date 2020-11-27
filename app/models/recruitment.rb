class Recruitment < ApplicationRecord

  has_many :likes, dependent: :destroy
  belongs_to :user


  def liked_by(user)
    Like.find_by(user_id: user.id, recruitment_id: id)
  end

  def self.search(search)
    search ? where('title LIKE ?', "%#{search}%") : all
  end


end
