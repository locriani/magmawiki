Factory.define :revision do |revision|
  revision.sequence :body do |s|
     "#{s} Some text"
  end
  revision.association :article
end