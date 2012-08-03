require 'spec_helper'

describe Article::Base do

  before(:each) do
    article = FactoryGirl.build(:article)
    article.slug = article.title #TODO: Create a real slug (better would be to create it in the Factory!)
    article.save
  end

  context "general validations" do
    it { should have_many :revisions }
    it { should belong_to :namespace }
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
    it { should validate_uniqueness_of :slug }
  end
end
