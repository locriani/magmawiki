require 'spec_helper'

describe Article do
  context "general validations" do
    
    before :all do
      Article.delete_all
      article = Factory.create(:article)
    end
    
    it { should have_many :revisions }
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
  end
end
