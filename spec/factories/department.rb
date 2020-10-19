FactoryBot.define do
  
  factory :administration, class: Department do
    name { 'administration' }
  end

  factory :development, class: Department do
    name { 'development' }
  end

end