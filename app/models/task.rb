class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  enum status: { no_started: 0, in_progress: 1, completed: 2 }
  enum priority: { high: 0, middle: 1, low: 2 }
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  scope :search, -> (search_params) do
    return if search_params.blank?
      if search_params[:title].present? && search_params[:status].present? && search_params[:label_id].present?
        title_like(search_params[:title])
        status_is(search_params[:status])
        label_is(search_params[:label_id])
      elsif search_params[:title].present? && search_params[:status].present?
        title_like(search_params[:title])
        status_is(search_params[:status])
      elsif search_params[:title].present? && search_params[:label_id].present?
        title_like(search_params[:title])
        label_is(search_params[:label_id])
      elsif search_params[:status].present? && search_params[:label_id].present?
        status_is(search_params[:status])
        label_is(search_params[:label_id])
      elsif search_params[:title].present?
        title_like(search_params[:title])
      elsif search_params[:status].present?
        status_is(search_params[:status])
      elsif search_params[:label_id].present?
        label_is(search_params[:label_id])
      end
  end
    scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") }
    scope :status_is, -> (status) { where(status: status) }
    scope :label_is, -> (label) { joins(:labels).where(labels: { id: params[:label_id] }) }
    scope :sort_deadline, -> { order(deadline: :desc) }
    scope :sort_created, -> { order(created_at: :desc) }
    scope :sort_priority, -> { order(priority: :asc) }
end
