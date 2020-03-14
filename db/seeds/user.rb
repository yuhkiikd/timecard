1.times do |i|
  User.create!(
    name: "admin",
    email: "amind@a.com",
    password: "hogehoge",
    admin: true,
    affiliation_id: 1,
    )
end

5.times do |i|
  User.create!(
    name: "normal",
    email: "normal-#{i + 1}@a.com",
    password: "hogehoge",
    admin: false,
    affiliation_id: 1 + i,
    )
end