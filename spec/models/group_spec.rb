require 'spec_helper'

describe Group do
  it { should have_many :users }
  it { should have_many :permissions }
  it { should have_many :restrictions }
end
