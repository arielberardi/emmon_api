require 'factories/role'

FactoryBot.define do
  
  factory :rule, class: Rule do
    section { 'Roles' }
    can_create { true }
    can_read { true }
    can_update { true }
    can_delete { true }
    role { Role.find_by(name: DEFAULT_ROLE[:employee]) }
  end

end