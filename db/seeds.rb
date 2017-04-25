
puts "Create 5 User of TEAM"
User.create!(username: "admin",
             email: "admin@gmail.com",
             password:              "admin1",
             password_confirmation: "admin1")
User.create!(username:  "nam",
             email: "nam@gmail.com",
             password:              "123456",
             password_confirmation: "123456")
User.create!(username:  "hien",
             email: "hien@gmail.com",
             password:              "123456",
             password_confirmation: "123456")
User.create!(username:  "duc",
             email: "duc@gmail.com",
             password:              "123456",
             password_confirmation: "123456")

User.create!(username:  "long",
             email: "long@gmail.com",
             password:              "123456",
             password_confirmation: "123456")


puts "Faker 50 Food"
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.foods.create!(
  	description: content,
  	name:Faker::Name.title,
  	address: Faker::Address.street_address,
  	price: Faker::Number.decimal(2, 3),
  	file:Faker::Avatar.image("my-own-slug", "50x50"),
  	) }
  end

# puts "Creat foods"

# # Microposts
# users = User.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.foods.create!(content: content) }
# end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

puts "Finish"