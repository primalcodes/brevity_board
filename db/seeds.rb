# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# --------------------------------------------
puts "\nCreate users"
# --------------------------------------------
1.upto(25) do
  u = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    about_me: Faker::Quote.matz
  )
  puts u.email
end

# --------------------------------------------
puts "\nCreate 100 posts from random authors"
# --------------------------------------------
1.upto(100) do
  post = Post.create(
    author: User.all.sample,
    title: Faker::TvShows::BigBangTheory.quote,
    body: Faker::Lorem.paragraph
  )
  puts post.title

  # Create a random number of comments (up to 7) per post
  1.upto((1..7).to_a.sample) do
    comment = Comment.new(
      author: User.all.sample,
      body: [Faker::Lorem.question, Faker::TvShows::MichaelScott.quote].sample
    )
    post.comments << comment
  end
  puts "#{post.comments.length} Comment(s)\n"
end
