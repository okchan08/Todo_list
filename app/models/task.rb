class Task < ApplicationRecord
  enum status: { untouched: 0, inprogress: 1, done: 2 }
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :deadline, presence: true
end
