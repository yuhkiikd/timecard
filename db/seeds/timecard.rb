30.times do |i|
  TimeCard.create!(
    user_id: 1,
    year: 2020,
    month: 3,
    day: 1 + i,
    worked_in_at: DateTime.new(2020,3,1 + i,9 - 9),
    worked_out_at: DateTime.new(2020,3,1 + i,20 - 9),
    breaked_in_at: DateTime.new(2020,3,1 + i,12 - 9),
    breaked_out_at: DateTime.new(2020,3,1 + i,13 - 9),
    worked_time: 36000,
    breaked_time: 3600,
    overtime: 7200,
    affiliation_id: 1,
    )
end

30.times do |i|
  TimeCard.create!(
    user_id: 2,
    year: 2020,
    month: 3,
    day: 1 + i,
    worked_in_at: DateTime.new(2020,3,1 + i,9 - 9),
    worked_out_at: DateTime.new(2020,3,1 + i,19 - 9),
    breaked_in_at: DateTime.new(2020,3,1 + i,12 - 9),
    breaked_out_at: DateTime.new(2020,3,1 + i,13 - 9),
    worked_time: 32400,
    breaked_time: 3600,
    overtime: 3600,
    affiliation_id: 2,
    )
end