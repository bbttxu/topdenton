FactoryGirl.define do
  factory :food do
    sequence(:name) { |x| "food-name-#{x}" }
    sequence(:address) { |x| "#{(0..9).to_a.shuffle[0,3].join('')} Main Street" }
    city "Denton"
    state "TX"
    zipcode "76201"
    sequence(:phone) { |x| "#{(0..9).to_a.shuffle[0,9].join('')}" }

    after(:build) do |food, evaluator|
      food.tags = "#{('a'..'Z').to_a.shuffle[0,10].join('')}"
    end
  end
end