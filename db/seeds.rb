1.times do |i|
  Affiliation.create!(
    name: '総務部',
    )
end

1.times do |i|
  Affiliation.create!(
    name: '営業部',
    )
end

1.times do |i|
  User.create!(
    name: 'admin',
    email: 'admin@a.com',
    password: 'hogehoge',
    admin: true,
    affiliation_id: 1,
    )
end

1.times do |i|
  User.create!(
    name: 'normal',
    email: 'normal@a.com',
    password: 'hogehoge',
    admin: true,
    affiliation_id: 2,
    )
end