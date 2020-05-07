class Task < ApplicationRecord
  enum status: %w(未着手 着手 完了)
  enum priority: %w(低 中 高)
end
