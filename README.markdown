# GrabBag - a grab-and-go bag of Ruby

## Classes

* `GrabBag::Config` - a configuration DSL that makes it easy to pass multiple blocks to a method

Instead of this:

    some_method :tries => 2, :success => lambda {|response| complex_success_handling ... }, :error => lambda { complex_error_handling ... }, :timeout_handler => lambda { ... }

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

      c.timeout_handler do
        puts "Oh no, a timeout!"
      end
    end

Of course, if you like the single-line form, that also works.

Hypothetical implementation:

    def some_method(opts = {})
      config = GrabBag::Config.new(:success, :error, :timeout_handler, :tries => 5)
      config.parse_opts(opts)
      yield config if block_given?

      config.tries.times do |t|
        response = try_to_do_something(:timeout => config.timeout_handler)
        return config.success.call(response) if response
      end
      config.error.call
    end
