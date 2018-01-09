FactoryBot.define do
  factory :bookmark do
    title { Faker::Lorem.sentence  }

    sequence(:url) do |n|
      Faker::Internet.url("#{n}example")
    end

    sequence(:shortening) do |n|
      Faker::Internet.url("#{n}ie")
    end
  end
end
