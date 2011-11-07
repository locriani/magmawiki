require 'spec_helper'

describe Revision do
  it { should belong_to :article }
  it { should validate_presence_of :article_id }
end
