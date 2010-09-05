
class Array
  def squash
    self.flatten.compact.uniq
  end
end

class String
  def to_unix
    gsub("\r\n", "\n")
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

module WikiCloth
  class WikiLinkHandler
    def section_link(section)
	  "/editsec/#{section}/#{self.params[:pagename]}"
    end

    def template(template, args = "")
      tmpname = template.gsub(/\s/,"_")
      article = Article.find_by_slug(tmpname.downcase, :include => :current_revision)
      article.nil? ? nil : article.current_revision.body
    end
  end
end

