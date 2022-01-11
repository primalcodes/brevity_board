FactoryBot.define do
  factory :comment do
    author factory: :user
    post factory: :post
    body { "MyText" }
  end
end
