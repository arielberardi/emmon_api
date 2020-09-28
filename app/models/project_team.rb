class ProjectTeam < ApplicationRecord

  validates :project, :team, presence: true

  belongs_to :project
  belongs_to :team
end
