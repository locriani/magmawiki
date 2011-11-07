FactoryGirl.define do
  factory :article do
    sequence :title do |n|
      "title#{n}"
    end
  end
  
  factory :article_without_revision, :class => Article do
    sequence :title do |n|
      "title#{n}"
    end
  end
end