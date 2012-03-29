require 'spec_helper'

describe GrabBag::Config do
  describe "basic behavior" do
    def some_method(options = {}, &block)
      config = GrabBag::Config.new(:success, :tries => 3).handle(options, &block)

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

    it "allows assignment without equals during setup" do
      c = GrabBag::Config.new(:something)
      c.handle do |config|
        config.something 5
      end
      c.something.should == 5
    end
  end
end