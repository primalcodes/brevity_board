FactoryBot.define do
  factory :user do    
    email { Faker::Internet.email }
    name { Faker::TvShows::FamilyGuy.character }
    password { "password" }
    password_confirmation { "password" }
  end
end
