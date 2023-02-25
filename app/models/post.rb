class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :genre
  
  validates :customer_id,         presence: true
  validates :genre_id,         presence: true
  validates :name,         presence: true
  validates :subject,      presence: true
  validates :introduction, presence: true
  validates :is_active,    inclusion: [true, false]
  
end
