FactoryGirl.define do
  pw = RandomData.random_sentence

  factory :user do
    name RandomData.random_name
    sequence(:email){ "#{RandomData.random_word}@factory.com" }
    password pw
    role :standard
  end
end
