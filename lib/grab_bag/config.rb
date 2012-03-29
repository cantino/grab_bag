module GrabBag
  class Config
    def initialize(*args)
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

    def parse_opts(opts)
      @values.merge! opts
      self
    end

    def method_missing(method, *args, &block)
      key = method.to_s.sub(/=$/, '').to_sym
      if @params.has_key?(key)
        if block
          @values[key] = block
        elsif method.to_s =~ /=$/
          @values[key] = args.first
        else
          @values.has_key?(key) ? @values[key] : @params[key]
        end
      else
        super
      end
    end
  end
end
