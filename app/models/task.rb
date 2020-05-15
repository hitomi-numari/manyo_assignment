class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: { no_started: 0, in_progress: 1, completed: 2 }
  enum priority: { high: 0, middle: 1, low: 2 }

  scope :search, -> (search_params) do
    return if search_params.blank?
      if search_params[:title].present? && search_params[:status].present?
        title_like(search_params[:title])
        status_is(search_params[:status])
      elsif search_params[:title].present?
        title_like(search_params[:title])
      elsif search_params[:status].present?
        status_is(search_params[:status])
      end
  end
    scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") }
    scope :status_is, -> (status) { where(status: status) }
    scope :sort_deadline, -> { order(deadline: :desc) }
    scope :sort_created, -> { order(created_at: :desc) }
    scope :sort_priority, -> { order(priority: :asc) }
end
