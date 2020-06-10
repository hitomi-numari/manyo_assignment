FactoryBot.define do
  factory :user do
    # id { 1 }
    name { 'test_user_01' }
    email { 'test_user_01@sample.com' }
    password { '00000000' }
    admin { false }
  end
  factory :second_user, class: User do
    # id { 2 }
    name { 'test_user_02' }
    email { 'test_user_02@sample.com' }
    password { '00000000' }
    admin { true }
  end
end
