class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  def favorite?(user)
    favorite_users.include?(user)
  end
  
  def self.search(search)
    if search
      Micropost.where(['content LIKE ?', "%#{search}%"])
    else
      Micropost.all
    end
  end
  
end


