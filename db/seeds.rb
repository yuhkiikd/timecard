1.times do |i|
  Affiliation.create!(
    name: '総務部',
    )
end

1.times do |i|
  User.create!(
    name: 'admin2',
    email: 'admin2@a.com',
    password: 'hogehoge',
    admin: true,
    affiliation_id: 1,
    )
end