class User < ActiveRecord::Base
    has_many :comments
    has_many :posts
    
    has_secure_password
    before_save { |user| user.username = user.username.downcase }
    before_save { |user| user.email = user.email.downcase }
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
end
