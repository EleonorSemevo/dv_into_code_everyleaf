FactoryBot.define do
  factory :user1,  class: User do
    name { "loren" }
    email { "loren@gmail.com" }
    password_digest { "12345678" }
  end

  factory :user2, class: User do
    name { "semevo" }
    email { "semevo@gmail.com" }
    password_digest { "123456" }
  end

  factory :admin1, class: User do
    name { "loren" }
    email { "loren@gmail.com" }
    password_digest { "123456" }
    admin {true}
  end

  factory :admin2, class: User do
    name { "semevo" }
    email { "semevo@gmail.com" }
    password_digest { "123456" }
    admin {true}
  end

end
