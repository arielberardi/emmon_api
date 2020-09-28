class Department < ApplicationRecord

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { case_sensitive: false }

  has_many :users
end
