class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: {
    no_started: 0,
    in_progress: 1,
    completed: 2
  }
  enum priority: {
    high: 0,
    middle:1,
    low:2,
  }
end
