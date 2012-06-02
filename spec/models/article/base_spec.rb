require 'spec_helper'

describe Article::Base do
  context "general validations" do
    it { should have_many :revisions }
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
  end
end