progressbar = ProgressBar.create(title: 'Creating Users', total: USERS_TO_CREATE)

%i(k445566778899k@gmail.com user1@mailinator.com user2@mailinator.com').each do |email|
  User.create!(
    # first_name: Faker::Name.first_name,
    # last_name: Faker::Name.last_name,
    email: email,
    password: '123456789'
  )

  progressbar.increment
end