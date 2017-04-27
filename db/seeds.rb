
puts "Create User"
User.create!(username: "admin111",
             email: "admin@gmail.com",
             password:              "admin1",
             password_confirmation: "admin1")
User.create!(username:  "namnguyen",
             email: "nam@gmail.com",
             password:              "123456",
             password_confirmation: "123456")

# puts "Faker 50 Users"
# 5.times do |n|
#   password = Faker::Internet.password
#   User.create! username: Faker::Name.name_with_middle , email: Faker::Internet.email, password: password, password_confirmation: password
# end

puts "Finish"

