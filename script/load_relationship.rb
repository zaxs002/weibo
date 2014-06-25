User.transaction do
  users = User.all
  user = users.first

  followed_users = users[2..50]
  follower = users[3..40]

  followed_users.each { |f| user.follow!(f) }
  follower.each do |f|
    f.follow!(user)
  end
end