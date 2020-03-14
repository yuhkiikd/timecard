

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