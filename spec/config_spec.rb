require 'spec_helper'

describe GrabBag::Config do
  describe "basic behavior" do
    def some_method(opts = {})
      config = GrabBag::Config.new(:success, :tries => 3).parse_opts(opts)
      yield config if block_given?

      config.tries.times do
        config.success.call
      end
    end

    it "works as a block" do
      counter = 0

      some_method do |c|
        c.success do
          counter += 1
        end
        c.tries = 5
      end

      counter.should == 5
    end

    it "works as options" do
      counter = 0
      some_method(:tries => 5, :success => lambda { counter += 1 })
      counter.should == 5
    end

    it "has defaults" do
      counter = 0

      some_method do |c|
        c.success do
          counter += 1
        end
      end

      counter.should == 3
    end

    it "works with false values" do
      c = GrabBag::Config.new(:false => true)
      c.false.should == true
      c.false = false
      c.false.should == false
    end
  end
end