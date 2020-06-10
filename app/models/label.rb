class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings
  # scope :label_search, -> (label_id) { find_by(id: label_id).labeling_tasks }
end
