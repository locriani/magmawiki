FactoryGirl.define do
  factory :revision, :class => Article::Revision do
    association :article
  end
end