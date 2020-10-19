require 'role'
require 'factories/role'
require 'factories/user'

FactoryBot.define do
  
  factory :admin, class: User do
    name { 'Admin Test' }
    email { 'admin@test.com' }
    password { '123456' }
    password_confirmation { '123456' }
    role { FactoryBot.create(:role_admin) }
  end

  factory :employee, class: User do
    name { 'Employee Test' }
    email { 'employee@test.com' }
    password { '123456' }
    password_confirmation { '123456' }
    role { FactoryBot.create(:role_employee) }
  end

  factory :project_manager, class: User do
    name { 'PM Test' }
    email { 'pm@test.com' }
    password { '123456' }
    password_confirmation { '123456' }
    role { FactoryBot.create(:role_pm) }
  end

  factory :client, class: User do
    name { 'Client Test' }
    email { 'client@test.com' }
    password { '123456' }
    password_confirmation { '123456' }
    role { FactoryBot.create(:role_client) }
  end


end