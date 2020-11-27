class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recruitment

  validates :user_id, uniqueness: { scope: :recruitment_id }

end
