puts "Create 5 User of TEAM"
User.create!(username: "admin111",
 email: "admin@gmail.com",
 password:              "admin1",
 password_confirmation: "admin1")
User.create!(username:  "namnguyen",
 email: "nam@gmail.com",
 password:              "123456",
 password_confirmation: "123456")
User.create!(username:  "hienvu",
 email: "hien@gmail.com",
 password:              "123456",
 password_confirmation: "123456")
User.create!(username:  "ducdoanh",
 email: "duc@gmail.com",
 password:              "123456",
 password_confirmation: "123456")

User.create!(username:  "longtran",
 email: "long@gmail.com",
 password:              "123456",
 password_confirmation: "123456")

puts "Faker 50 Food"
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.foods.create!(
  	description: content,
  	name:Faker::Name.name ,
  	address: Faker::Address.street_address,
  	price: Faker::Number.decimal(2, 3),
  	file:Faker::Avatar.image("my-own-slug", "50x50"),
  	) }
end

# puts "create 20 user "
# 20.times do |n|
#   name  = Faker::Name.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(username:  name,
#    email: email,
#    password:              password,
#    password_confirmation: password,
#    )
# end


# Following relationships
users = User.all
user  = users.first
following = users[2..10]
followers = users[3..15]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

puts "Finish"
