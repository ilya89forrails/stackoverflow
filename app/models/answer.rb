class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  # validates :body, length: { maximum: 5 }
end
