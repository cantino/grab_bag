# GrabBag - a grab-and-go bag of Ruby

## Classes

* `GrabBag::Config` - a configuration DSL that makes it easy to pass multiple blocks to a method

Instead of this:

    some_method :tries => 2, :success => lambda {|response| complex_success_handling ... }, :error => lambda { complex_error_handling ... }

Do this:

    some_method do |c|
      c.tries = 2

      c.success do |response|
        complex_success_handling
        ...
      end

      c.error do
        complex_error_handling
        ...
      end
    end

Hypothetical implementation:

    def some_method
      config = GrabBag::Config.new(:success, :error, :tries => 5)
      yield config
      config.tries.times do |t|
        response = try_to_do_something
        return config.success.call(response) if response
      end
      config.error.call
    end
