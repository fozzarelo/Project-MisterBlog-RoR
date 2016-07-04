
User.create	first_name: "admin",
        email:		"q@q.q",
        password: "admin",
        admin: true

6.times do
   User.create	first_name: Faker::Name.first_name,
                last_name: 	Faker::Name.last_name,
                email:		Faker::Internet.email,
                password: "p"

end

Category.create(title: "Ruby")
Category.create(title: "Health")
Category.create(title: "Dogs")
Category.create(title: "Politics")
Category.create(title: "Finance")
Category.create(title: "SQL")
Category.create(title: "Life")
Category.create(title: "Economy")

30.times do
  Post.create  	title:  		Faker::Book.title,
                body:    		Faker::Lorem.paragraph,
                user_id: 		rand(5)+1
end

90.times do
  Comment.create	 body: 			Faker::Lorem.paragraph,
                   user_id: 	rand(5)+1,
                   post_id:		rand(29)+1
end

60.times do
  Tagging.create(post_id: rand(29)+1, category_id: rand(7)+1)
end

60.times do
  Like.create(post_id: rand(29)+1, user_id: rand(5)+1)
end

60.times do
  Fav.create(post_id: rand(29)+1, user_id: rand(5)+1)
end

puts "Seeded"
