User.create!(
  name: "管理者",
  email: "admin@test.com",
  password: "123456"
  admin: true
)

10.times do |n|
  name: "シードくん#{n + 1}"
  email: "seed#{n + 1}@test.com"
  password: "123456"
  
  User.create!(name: name, email: email, password: password, admin:false)
end

10.times do |n|
  name = "label#{n}"

  Label.create!(name: name)
end

