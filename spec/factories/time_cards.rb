FactoryBot.define do
  factory :timecard_1, class: TimeCard do
    user_id { 1 }
    affiliation_id { 1 }
    year { Time.current.year }
    month { Time.current.month }
    day { Time.current.day }
    worked_in_at { Time.current }
    breaked_in_at { Time.current + 3600 }
    breaked_out_at { Time.current + 7200 }
    worked_out_at { Time.current + 32400 }
    worked_time { 28800 }
    breaked_time { 3600 }
    overtime { 0 }
  end
end