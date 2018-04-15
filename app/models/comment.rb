class Comment < ActiveRecord::Base
  validates :text, :user, :gist, presence: true

  belongs_to :gist
  belongs_to :user
end
