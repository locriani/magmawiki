require 'spec_helper'

describe Article::Namespace do
  context "general validations" do
    it { should have_many :articles }
    it { should validate_uniqueness_of :slug }
  end
end
