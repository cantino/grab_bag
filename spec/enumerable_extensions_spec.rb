require 'spec_helper'
require 'grab_bag/enumerable_extensions'

describe Enumerable do
  describe "counts_map" do
    it "works without an argument" do
      [1,2,3,1].count_map.should == { 1 => 2, 2 => 1, 3 => 1 }
    end

    it "works with an argument" do
      %w[a aa aaa bbb].count_map(:length).should == { 1 => 1, 2 => 1, 3 => 2 }
      [[1,2,3], [3,4,5]].count_map(:[], 1).should == { 2 => 1, 4 => 1 }
    end

    it "works with a block" do
      [5, 3, 1, 2].count_map {|i| i % 2 == 0 }.should == { true => 1, false => 3 }
    end
  end

  describe "identity_map" do
    it "works without an argument" do
      [1,2,3,1].identity_map.should == { 1 => 1, 2 => 2, 3 => 3 }
    end

    it "works with an argument" do
      %w[a aa aaa bbb].identity_map(:length).should == { 1 => "a", 2 => "aa", 3 => "bbb" }
      [[1,2,3], [3,4,5]].identity_map(:[], 1).should == { 2 => [1,2,3], 4 => [3,4,5] }
    end

    it "works with a block" do
      [5, 3, 1].identity_map {|i| i - 1 }.should == { 4 => 5, 2 => 3, 0 => 1 }
    end
  end
end