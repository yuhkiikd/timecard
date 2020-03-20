FactoryBot.define do
  factory :user_1, class: User do
    id { 1 }
    name { 'test_1' }
    email { 'test_1@a.com' }
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
    admin { false }
    confirmed_at { '2020,3,1,9' }
    confirmation_sent_at { '2020,3,2,9' }
    affiliation_id { 2 }

      trait :change_charactor do
        id { 3 }
        email { 'Test_3@A.com' }
      end
  end

  factory :user_3, class: User do
    id { 3 }
    name { 'test_3' }
    email { 'test_3@a.com' }
    password { 'hogehoge' }
    admin { true }
    confirmed_at { '2020,3,1,9' }
    confirmation_sent_at { '2020,3,2,9' }
    affiliation_id { 1 }
  end

  factory :user_4, class: User do
    id { 4 }
    name { 'test_4' }
    email { 'test_4@a.com' }
    password { 'hogehoge' }
    confirmed_at { '2020,3,1,9' }
    confirmation_sent_at { '2020,3,2,9' }
    admin { true }
    affiliation_id { 1 }
  end
end