class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_one_attached :image, dependent: :destroy

  def creator?(current_user_id)
    user == current_user_id
  end

  def not_creator?(user_id)
    !creator? user_id
  end
end
