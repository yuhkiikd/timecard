FactoryBot.define do
  factory :affiliation_1, class: Affiliation do
    id { 1 }
    name { '営業部' }
  end

  factory :affiliation_2, class: Affiliation do
    id { 2 }
    name { '製造部' }
  end

  factory :affiliation_3, class: Affiliation do
    id { 3 }
    name { '人事部' }
  end
end