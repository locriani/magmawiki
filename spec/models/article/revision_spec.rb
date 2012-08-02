require 'spec_helper'

describe Article::Revision do
  it { should belong_to :article }
  it { should validate_presence_of :base_id }
end