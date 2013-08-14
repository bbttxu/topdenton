FactoryGirl.define do
  factory :user do
    sequence(:uid) { |x| "uid-#{x}" }
    sequence(:name) { |x| "name-#{x}" }
    provider "twitter"
  end
end