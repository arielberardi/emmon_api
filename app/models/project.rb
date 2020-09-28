class Project < ApplicationRecord

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { case_sensitive: false } 
  validates :start_date, :end_date, presence: true
  validate  :end_date_after_or_equal_start_date
  validate  :project_manager_role
  validate  :client_role

  belongs_to :project_manager, class_name: 'User'
  belongs_to :client, class_name: 'User'

  has_many :tasks
  has_many :project_teams
  has_many :teams, through: :project_teams

  private

  def end_date_after_or_equal_start_date
    if self.end_date < self.start_date
      errors.add(:end_date, "can't be lower than start date")
    end
  end

  def project_manager_role
    if self.project_manager.role == nil or self.project_manager.role.name != DEFAULT_ROLES[:project_manager]
      errors.add(:project_manager, "user role is not project manager")
    end
  end

  def client_role
    if self.client.role == nil or self.client.role.name != DEFAULT_ROLES[:client]
      errors.add(:client, "user role is not client")
    end
  end
end
