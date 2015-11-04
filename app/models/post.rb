class Post < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    belongs_to :user

    def date_published
         created_at.localtime.strftime("%A, %B %-d, %Y at %l:%M %p")
    end
end
