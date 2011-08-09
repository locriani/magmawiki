class Array
  def squash
    self.flatten.compact.uniq
  end
end

class String
  def to_unix
    gsub("\r\n", "\n")
  end
  
  def slugify
    downcase.tr(' ','_').gsub(/[\!-\.;-@\[-\^`\{-~]/,"").gsub(/:/,":_").gsub(/(_{2,})/, '_').chomp("_")
  end
end

class ActiveRecord::Base
  def self.[](n)
    find n
  end
end

class Hash
  def self.of_arrays
    new {|h,k| h[k] = [] }
  end

  def self.of_integers
    new(0)
  end
end

module ActionView::Helpers::DateHelper
  def time_ago_in_words(from_time, include_seconds = false)
    distance_of_time_in_words(from_time, Time.zone.now, include_seconds)
  end
end


module Enumerable

  def split_at(matcher=nil, &block)
    return self unless self.any?

    if matcher.nil?
      boundary_test = block
    else
      if matcher.is_a? String or matcher.is_a? Regexp
        boundary_test = proc { |e| e[matcher] }
      else
        raise "I don't know how to split with #{matcher}"
      end
    end

    chunks = []
    current_chunk = []

    each do |e|

      if boundary_test.call(e)
        next if current_chunk.empty?

        chunks << current_chunk
        current_chunk = []

      else
        current_chunk << e
      end

    end

    chunks << current_chunk if current_chunk.any?
    chunks
  end

end

class Hash
  def recursive_find_by_key(key)
    # Create a stack of hashes to search through for the needle which
    # is initially this hash
    stack = [ self ]

    # So long as there are more haystacks to search...
    while (to_search = stack.pop)
      # ...keep searching for this particular key...
      to_search.each do |k, v|
        # ...and return the corresponding value if it is found.
        return v if (k == key)

        # If this value can be recursively searched...
        if (v.respond_to?(:recursive_find_by_key))
          # ...push that on to the list of places to search.
          stack << v
        end
      end
    end
  end
end
