module GrabBag
  class Config
    def initialize(*args)
      @mode = :access
      @values = {}
      @params = args.inject({}) do |memo, v|
        if v.is_a?(Hash)
          memo.merge!(v)
        else
          memo[v.to_sym] = nil
        end
        memo
      end
    end

    def handle(options = {}, &block)
      @values.merge! options
      in_setup_mode do
        block.call(self) if block
      end
      self
    end

    def in_setup_mode
      @mode = :setup
      yield
    ensure
      @mode = :access
    end

    def method_missing(method, *args, &block)
      key = method.to_s.sub(/=$/, '').to_sym
      if @params.has_key?(key)
        if block
          @values[key] = block
        elsif method.to_s =~ /=$/
          @values[key] = args.first
        else
          if @mode == :setup
            @values[key] = args.first
          else
            @values.has_key?(key) ? @values[key] : @params[key]
          end
        end
      else
        super
      end
    end
  end
end
