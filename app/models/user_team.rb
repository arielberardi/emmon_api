class UserTeam < ApplicationRecord

  validates :employee, :team, presence: true
  validate  :employee_role

  belongs_to :employee, class_name: 'User'
  belongs_to :team

  private

  def employee_role
    if self.employee.role == nil or self.employee.role.name != DEFAULT_ROLES[:employee]
      errors.add(:employee, "user role must be employee")
    end
  end

end
