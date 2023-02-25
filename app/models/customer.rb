class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :posts
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana,  presence: true
  validates :user_name,       presence: true
  validates :is_deleted,      inclusion: [true, false]
  
  # ゲストログイン機能
  def self.guest
    find_or_create_by!(first_name: '用', last_name: '閲覧', first_name_kana: 'ヨウ', last_name_kana: 'エツラン', user_name: 'Guest' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.user_name = "Guest"
    end
  end
            
end
