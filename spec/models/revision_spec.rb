require 'spec_helper'

describe Revision do
  it { should belong_to :article }
end
