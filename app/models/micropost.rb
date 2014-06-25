class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :content, length:{maximum:140,minimum: 1},presence: true
  validates :user_id,presence:true

  default_scope -> {order 'created_at DESC'}

  def self.from_users_followed_by user
    f_ids = "SELECT followed_id FROM relationships
            WHERE follower_id = :user_id"
    where("user_id IN (#{f_ids}) OR user_id = :user_id",user_id:user)
  end

  def self.search s
    if s
      find(:all,conditions: ['content LIKE ?',"%#{s}%"])
    else
      find(:all)
    end
  end

end
