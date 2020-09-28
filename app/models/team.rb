class Team < ApplicationRecord

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { case_sensitive: false }

  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :project_teams
  has_many :projects, through: :project_teams
end
