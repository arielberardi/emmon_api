class Rule < ApplicationRecord
    
  validates :section, presence: true, length: { maximum: 255 }
  validates :section, uniqueness: { case_sensitive: false, scope: [:role_id] }

  belongs_to :role
end
