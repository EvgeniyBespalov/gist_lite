class Gist < ActiveRecord::Base
  validates :file_name, :text, :user, presence: true

  belongs_to :user
  has_many :comments
end
