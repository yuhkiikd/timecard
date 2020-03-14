##所属
1.times do |i|
  Affiliation.create!(
    name: '総務部',
    )
end

1.times do |i|
  Affiliation.create!(
    name: '法務部',
    )
end

1.times do |i|
  Affiliation.create!(
    name: '営業部',
    )
end

1.times do |i|
  Affiliation.create!(
    name: '広報部',
    )
end

1.times do |i|
  Affiliation.create!(
    name: '役員',
    )
end

##ユーザー
5.times do |i|
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

5.times do |i|
  TimeCard.create!(
    user_id: 2,
    year: 2020,
    month: 3,
    day: 3 + i,
    worked_in_at: DateTime.new(2020,3,3 + i,9 - 9),
    worked_out_at: DateTime.new(2020,3,3 + i,19 - 9),
    breaked_in_at: DateTime.new(2020,3,3 + i,12 - 9),
    breaked_out_at: DateTime.new(2020,3,3 + i,13 - 9),
    worked_time: 32400,
    breaked_time: 3600,
    overtime: 3600,
    affiliation_id: 1,
    )
end

5.times do |i|
  TimeCard.create!(
    user_id: 2,
    year: 2020,
    month: 3,
    day: 8 + i,
    worked_in_at: DateTime.new(2020,3,8 + i,9 - 9),
    worked_out_at: DateTime.new(2020,3,8 + i,20 - 9),
    breaked_in_at: DateTime.new(2020,3,8 + i,12 - 9),
    breaked_out_at: DateTime.new(2020,3,8 + i,13 - 9),
    worked_time: 36000,
    breaked_time: 3600,
    overtime: 7200,
    affiliation_id: 3,
    )
end

5.times do |i|
  TimeCard.create!(
    user_id: 3,
    year: 2020,
    month: 3,
    day: 6 + i,
    worked_in_at: DateTime.new(2020,3,6 + i,9 - 9),
    worked_out_at: DateTime.new(2020,3,6 + i,18 - 9),
    breaked_in_at: DateTime.new(2020,3,6 + i,12 - 9),
    breaked_out_at: DateTime.new(2020,3,6 + i,13 - 9),
    worked_time: 28000,
    breaked_time: 3600,
    overtime: 0,
    affiliation_id: 3,
    )
end

5.times do |i|
  TimeCard.create!(
    user_id: 4,
    year: 2020,
    month: 3,
    day: 6 + i,
    worked_in_at: DateTime.new(2020,3,6 + i,9 - 9),
    worked_out_at: DateTime.new(2020,3,6 + i,21 - 9),
    breaked_in_at: DateTime.new(2020,3,6 + i,12 - 9),
    breaked_out_at: DateTime.new(2020,3,6 + i,13 - 9),
    worked_time: 39600,
    breaked_time: 3600,
    overtime: 10800,
    affiliation_id: 4,
    )
end

##タイムカード
1.times do |i|
  User.create!(
    name: "admin",
    email: "amind@a.com",
    password: "hogehoge",
    admin: true,
    affiliation_id: 1,
    )
end

19.times do |i|
  User.create!(
    name: "normal",
    email: "normal-#{i + 1}@a.com",
    password: "hogehoge",
    admin: false,
    affiliation_id: i + 1,
    )
end