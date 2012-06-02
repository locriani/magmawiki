FactoryGirl.define do
  factory :article, :class => Article::Base do
    sequence :title do |n|
      "title#{n}"
    end
  end
  
  factory :article_without_revision, :class => Article::Base do
    sequence :title do |n|
      "title#{n}"
    end
  end
end