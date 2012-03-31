module Enumerable
  def identity_map(*args)
    inject({}) do |m, v|
      if args.length > 0
        m[v.send(*args)] = v
      elsif block_given?
        m[yield(v)] = v
      else
        m[v] = v
      end
      m
    end
  end

  def count_map(*args)
    inject({}) do |m, v|
      r = if args.length > 0
            v.send(*args)
          elsif block_given?
            yield v
          else
            v
          end
      m[r] ||= 0
      m[r] += 1
      m
    end
  end
end