Factory(:article) do |article|
  article.sequence :title do |n|
    "Some Title ##{n}"
  end
end