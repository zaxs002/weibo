User.transaction do
  (1...100).each do |i|
    name  = Faker::Name.name
    email = "example-#{i+1}@railstutorial.org"
    password  = "password"
    User.create!(name: name,
        email: email,
        password: password,
        password_confirmation: password)
  end
end