FactoryBot.use_parent_strategy = false

FactoryBot.define do
  sequence(:email) do |n|
    "user#{n}@example.com"
  end

  sequence(:name) do |n|
    "name #{n}"
  end

  sequence(:title) do |n|
    "name #{n}"
  end

  factory :instrumental do
    title
    track { "mycustomtrack.mp3" }
  end

  factory :instrumental_like do
    association :instrumental
    association :user
  end

  factory :user do
    email
    name
    password { "foobar" }

    trait :with_facebook_auth do
      auth_provider { "facebook" }
      auth_uid {"12345"}
      email { "facebook_oauth2@example.com" }
      image_url { "facebook_oauth.png" }
    end

    trait :with_google_auth do
      auth_provider { "google_oauth2" }
      auth_uid {"12345"}
      email { "google_oauth2@example.com" }
      image_url { "google_oauth.png" }
    end
  end

end
