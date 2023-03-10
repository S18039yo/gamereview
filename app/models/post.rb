class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :genre
  has_many :bookmarks,     dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  validates :customer_id,  presence: true
  validates :genre_id,     presence: true
  validates :name,         presence: true
  validates :subject,      presence: true
  validates :introduction, presence: true
  validates :is_active,    inclusion: [true, false]
  
  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("name LIKE?","#{word}")
    elsif search == "partial_match"
      @post = Post.where("name LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
end
