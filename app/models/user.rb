class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #validation
  validates :name,
            :email,
            :password,
            :password_confirmation, presence: true
  
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,20}+\z/i}
  validates :name, length: { maximum: 20 }
  validates :email, uniqueness:true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  # associate
  has_many :animals
  has_many :comments
  has_many :rooms
  has_many :took_animals, foreign_key: "taker_id", class_name: "Animal"
  has_many :giving_animals, -> { where("taker_id is NULL") }, foreign_key: "giver_id", class_name: "Animal"
  has_many :gived_animals, -> { where("taker_id is not NULL") }, foreign_key: "giver_id", class_name: "Animal"
  mount_uploader :icon, ImageUploader
  mount_uploader :header_image, ImageUploader
  
  def remember_me
    true
  end
end
