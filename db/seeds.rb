1.times do |i|
  User.create!(
    name: 'admin',
    email: 'admin2@a.com',
    password: 'hogehoge',
    affiliation_id: 1,
    admin: true,
  )
end