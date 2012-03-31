# GrabBag - a grab-and-go bag of Ruby

## Classes

### GrabBag::Config

A configuration DSL that makes it easy to pass multiple blocks to a method.

Instead of this:

    some_method :tries => 2, :success => lambda {|response| complex_success_handling ... }, :error => lambda { complex_error_handling ... }, :timeout_handler => lambda { ... }

Do this:

    some_method do |c|
      c.tries 2  # or c.tries = 2

      c.success do |response|
        complex_success_handling
        ...
      end

      c.error do
        complex_error_handling
        ...
      end

      c.timeout_handler do
        puts "Oh no, a timeout!"
      end
    end

Of course, if you like the single-line form, that also works.

Hypothetical implementation:

    def some_method(options = {})
      config = GrabBag::Config.new(:success, :error, :timeout_handler, :tries => 5).handle(options, &block)

      config.tries.times do |t|
        response = try_to_do_something(:timeout => config.timeout_handler)
        return config.success.call(response) if response
      end
      config.error.call
    end

### EnumerableExtensions

EnumerableExtensions has various mapping helpers.  Honestly, these can all be done with Rails' `group_by`, but here they are broken out.

    require 'grab_bag/enumerable_extensions'

    [:a, :b, :c, :d].identity_map.should == { :a => :a, :b => :b, :c => :c, :d => :d }
    ["a", "abc"].identity_map(:length).should == { 1 => "a", 3 => "abc" }
    [
        { :type => :animal, :name => "Moose" },
        { :type => :plant, :name => "Coconut" },
        { :type => :animal, :name => "Hippo" }
    ].count_map([], :type).should == { :animal => 2, :plant => 1 }

