require 'spec_helper'

describe Article do
  before do 
    Factory.create(:article)
  end
  it { should have_many :revisions }
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title }
end
