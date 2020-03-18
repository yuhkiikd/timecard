FactoryBot.define do
  factory :user_1, class: User do
    id { 1 }
    name { 'test_1' }
    email { 'test_1@a.com' }
    encrypted_password { 'hogehoge' }
    password { 'hogehoge' }
    admin { true }
    confirmed_at { '2020,3,1,9' }
    confirmation_sent_at { '2020,3,2,9' }
    affiliation_id { 1 }
  end

  factory :user_2, class: User do
    id { 2 }
    name { 'test_2' }
    email { 'test_2@a.com' }
    encrypted_password { 'hogehoge' }
    password { 'hogehoge' }
    admin { true }
    confirmed_at { '2020,3,1,9' }
    confirmation_sent_at { '2020,3,2,9' }
    affiliation_id { 2 }
  end
end