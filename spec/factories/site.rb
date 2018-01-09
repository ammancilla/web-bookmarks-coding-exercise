FactoryBot.define do
  factory :site do
    sequence(:url) do |n|
      Faker::Internet.url("#{n}example")
    end

    factory :site_with_bookmarks do
      transient do
        bookmarks_count 1
      end

      after(:create) do |site, evaluator|
        evaluator.bookmarks_count.each_with_index do |b, i|
          bookmark_url = "#{site.url}/#{Faker::Internet.slug}-#{i}"
          create(:bookmark, site: site, url: bookmark_url)
        end
      end
    end
  end
end
