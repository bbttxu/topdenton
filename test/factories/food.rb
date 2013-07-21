FactoryGirl.define do
  factory :food do
    sequence(:name) { |x| "food-name-#{x}" }
  end
end