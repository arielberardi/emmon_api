FactoryBot.define do
  
  factory :role_pm, class: Role do
    name { DEFAULT_ROLES[:project_manager] }
  end

  factory :role_client, class: Role do
    name { DEFAULT_ROLES[:client] }
  end

  factory :role_employee, class: Role do
    name { DEFAULT_ROLES[:employee] }
  end

  factory :role_admin, class: Role do
    name { DEFAULT_ROLES[:admin] }
  end

end