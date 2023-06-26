FactoryBot.define do
  factory :user do
    name { "ユーザ1" }
    email { "xxxx@test.com" }
    password { "123456" }
    password_confirmation {"123456"}
    admin {true}
  end

  factory :second_user, class: User do
    name { "ユーザ2" }
    email { "yyyy@test.com" }
    password { "123456" }
    password_confirmation {"123456"}
    admin {false}
  end
end
