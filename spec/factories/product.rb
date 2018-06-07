FactoryBot.define do
  factory :product do
    title 'Ruby'
    description 'Ruby Learning'
    price 20
    category { create(:category) }
  end
end
