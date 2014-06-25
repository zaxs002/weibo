User.transaction do
  users = User.all(limit:6)
  50.times do |i|
    content = Faker::Lorem.sentence(5)
    users.each do |u|
      u.microposts.create!(content:content)
    end
  end
end