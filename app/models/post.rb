class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :genre
  has_many :bookmarks, dependent: :destroy
  
  validates :customer_id,         presence: true
  validates :genre_id,         presence: true
  validates :name,         presence: true
  validates :subject,      presence: true
  validates :introduction, presence: true
  validates :is_active,    inclusion: [true, false]
  
  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
  end
  
end
