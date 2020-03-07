10.times do |i|
  TimeCard.create!(
    user_id: 17,
    year: 2020,
    month: 3,
    day: 1 + i,
    worked_in_at: DateTime.parse('2020-02-01 00:00:00') + i,
    worked_out_at: DateTime.parse('2020-02-01 11:00:00') + i,
    breaked_in_at: DateTime.parse('2020-02-01 04:00:00') + i,
    breaked_out_at: DateTime.parse('2020-02-01 05:00:00') + i,
  )
end