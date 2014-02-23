FactoryGirl.define do

  factory :user do
    name # uses sequence (or try { Faker::Name.name }
    shareholder false
    shareholding_percent 0
    created_at Time.now
    updated_at Time.now

    # the after(:create) yields two values; the user instance itself and the
    # evaluator, which stores all values from the factory, including ignored
    # attributes; we make sure the user is associated properly to the user
    after(:create) do |user, evaluator|
      create(:identity, :facebook, user: user)
      create(:identity, :twitter, user: user)
    end

  end

  def some_user
    User.find(:first) || factory(:user)
  end


  factory :shareholder, :parent => :user do
    shareholder true
    shareholding_percent 20
  end


  factory :identity do
    uid 

    trait :facebook do
      provider_name 'Facebook'
    end

    trait :twitter do
      provider_name 'Twitter'
    end
    user
  end


end
