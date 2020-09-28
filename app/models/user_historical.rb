class UserHistorical < ApplicationRecord

  validates :end_date, :start_date, presence: true
  validate :end_date_after_or_equal_start_date

  belongs_to :user

  private

  def end_date_after_or_equal_start_date
    if self.end_date < self.start_date
      errors.add(:end_date, "can't be lower than start date")
    end
  end
end
