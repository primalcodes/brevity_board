FactoryBot.define do
  factory :post do
    author factory: :user
    title { Faker::Company.bs }
    body { "MyText" }
  end
end
