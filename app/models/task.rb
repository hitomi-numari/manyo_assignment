class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  enum status: { no_started: 0, in_progress: 1, completed: 2 }
  enum priority: { high: 0, middle: 1, low: 2 }
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  scope :search, -> (task_search_params) do
    return if task_search_params.blank?
      if task_search_params[:title].present? && task_search_params[:status].present? && task_search_params[:label_id].present?
        title_like(task_search_params[:title])
        .status_is(task_search_params[:status])
        .label_is(task_search_params[:label_id])
      elsif task_search_params[:title].present? && task_search_params[:status].present?
        title_like(task_search_params[:title])
        .status_is(task_search_params[:status])
      elsif task_search_params[:title].present? && task_search_params[:label_id].present?
        title_like(task_search_params[:title])
        .label_is(task_search_params[:label_id])
      elsif task_search_params[:status].present? && task_search_params[:label_id].present?
        status_is(task_search_params[:status])
        .label_is(task_search_params[:label_id])
      elsif task_search_params[:title].present?
        title_like(task_search_params[:title])
      elsif task_search_params[:status].present?
        status_is(task_search_params[:status])
      elsif task_search_params[:label_id].present?
        label_is(task_search_params[:label_id])
      end
  end
    scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") }
    scope :status_is, -> (status) { where(status: status) }
    scope :label_is, -> (label_id) { joins(:labels).where(labels: { id: label_id }) }
    scope :sort_deadline, -> { order(deadline: :desc) }
    scope :sort_created, -> { order(created_at: :desc) }
    scope :sort_priority, -> { order(priority: :asc) }
end
