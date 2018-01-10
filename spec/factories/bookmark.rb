FactoryBot.define do
  factory :bookmark do
    title { Faker::Lorem.sentence }

    sequence(:url) do |n|
      Faker::Internet.url("bookmark#{n}.co")
    end

    sequence(:shortening) do |n|
      Faker::Internet.url("bmk#{n}.co")
    end
  end
end
