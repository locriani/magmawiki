FactoryGirl.define do
  factory :article do
    sequence :title do |n|
      "title#{n}"
    end
  end
end