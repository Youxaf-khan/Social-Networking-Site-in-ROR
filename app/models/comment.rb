class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  default_scope { order(created_at: :desc) }

  def creator?(current_user_id)
    user == current_user_id
  end

  def not_creator?(user_id)
    !creator? user_id
  end
end
