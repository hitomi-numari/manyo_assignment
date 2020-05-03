class Task < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :name
    validates :title
    validates :deadline
    validates :status
    validates :priority
  end
end
