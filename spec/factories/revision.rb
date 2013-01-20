# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :revision, class: Article::Revision, aliases: [:current_revision] do
    body "lorem ipsum"
    edit_summary "things were edited"
  end
end