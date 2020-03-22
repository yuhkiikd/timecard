

1.times do |i|
  User.create!(
    name: "admin",
    email: "admin@example.com",
    password: "hogehoge",
    admin: true,
    affiliation_id: 1,
    confirmation_sent_at: DateTime.new(2020,3,1,0),
    confirmed_at: DateTime.new(2020,3,1,0)
    )
end

20.times do |i|
  User.create!(
    name: "normal-#{i + 1}",
    email: "normal-#{i + 1}@example.com",
    password: "hogehoge",
    admin: false,
    affiliation_id: i + 1,
    confirmation_sent_at: DateTime.new(2020,3,1,0),
    confirmed_at: DateTime.new(2020,3,1,0)
    )
end