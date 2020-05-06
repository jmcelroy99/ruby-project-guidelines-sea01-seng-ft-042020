Review.destroy_all
Beer.destroy_all
User.destroy_all
Brewery.destroy_all

100.times do
     Beer.create({
          beer_name: Faker::Beer.name,
          beer_type: Faker::Beer.style,
          brewery_id: rand(1..50)
          })
end



50.times do
     Brewery.create({
          brewery_name: Faker::Beer.brand
     })
end

150.times do
     Review.create({
          beer_id: rand(1..100),
          user_id: rand(1..20),
          rating: rand(1..5),
          review: Faker::Hipster.sentence(word_count: 5)
     })
end

20.times do
     User.create({
          username: Faker::Twitter.screen_name
     })
end
