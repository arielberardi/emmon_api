class Task < ApplicationRecord

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { case_sensitive: false, scope: [:project_id, :user_id] }
  validates :priority, :end_date, :start_date, presence: true
  validates :current_hours, numericality: { greater_than_or_equal_to: 0 }
  validate  :end_date_after_or_equal_start_date

  belongs_to :project
  belongs_to :user

  private

  def end_date_after_or_equal_start_date
    if self.end_date < self.start_date
      errors.add(:end_date, "can't be lower than start date")
    end
  end
end
