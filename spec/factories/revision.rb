Factory.define :revision do |revision|
  revision.sequence :body do |s|
     "#{s} Some text goes here"
  end
  revision.association :article
end