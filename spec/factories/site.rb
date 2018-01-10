FactoryBot.define do
  factory :site do
    sequence(:url) do |n|
      Faker::Internet.url("site#{n}.co")
    end
  end
end
