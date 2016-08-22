FactoryGirl.define do
  sequence(:github_id) { |n| n }
  sequence(:email) { |n| "email#{n}@example.com" }

  factory :user do
    name { Faker::Name.name }
    email
    github_id
    github_login 'github_username'
    payment_url 'https://some-website.com/pay'

    trait :with_bid do
      after(:create) do |user|
        create(:bid, bidder: user)
      end
    end

    factory :admin_user do
      github_id { Admins.github_ids.first }

      factory :contracting_officer do
        contracting_officer true
      end
    end
  end
end
