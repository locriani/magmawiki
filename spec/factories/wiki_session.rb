FactoryGirl(:wiki_session) do |session|
  session.association :revision
  session.association :user
end