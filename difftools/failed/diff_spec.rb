require 'diff'

describe Range do
  
  it "actual_lasts" do
    (0...1).actual_last.should == 0
    (0...2).actual_last.should == 1
    (0..2).actual_last.should == 2
  end
  
end

describe "Diff" do
  
  it "gaps" do
    gap(1...2, 2...3).should == nil    
    gap(1...2, 3...4).should == (2...3)
    
    gap(0...1, 2...5).should == (1...2)
    gap(-1...0, 1...5).should == (0...1)
    
    a = PositionRange.new(0,1)
    b = PositionRange.new(3,4)
    gap(a,b).should == (1...3)    
  end
  
  it "diffs" do
    diff("hello", "hillo")
  end
    
end