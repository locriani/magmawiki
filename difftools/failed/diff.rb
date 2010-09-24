require 'rubygems'
require 'difflcs'
require 'diff_l_c_s/string'
require 'pp'
require 'colorize'

class Range
  
  def actual_last
    exclude_end? ? last-1 : last
  end

  def overlaps?(other)
    self.last >= other.first or self.first <= other.last
  end
  
end

def gap(r1, r2)
  # |   r1   |----|   r2   |
  
  return nil if r1.nil? or r2.nil?
  
  r1_next = (r1.actual_last+1)
  
  if r1_next == r2.first
    nil
  elsif r1_next > r2.first
    raise "Overlapping ranges: #{r1.inspect}, #{r2.inspect}"
  else
    (r1.actual_last+1...r2.first)
  end
end


def work_in_progress
  
  #puts highlight("highlight", 0..3)
  
  a_in, b_in = "hello there", "ahiillo here"
  #a_in, b_in = "hello", "hillo"
  
  p [:a, a_in]
  p [:b, b_in]
  puts
  
  result = a_in.diff(b_in)
  
  sames = result[:matched_old].zip(result[:matched_new]).sort_by{|a,b| p [a,b] ; a.first }
  sames = [ [-1...0, -1...0] ] + sames
  
  #pp sames
  
  sames.each_cons(2) do |pair_1, pair_2|
    a1, b1 = pair_1
    a2, b2 = pair_2
    p [:pair_1, pair_1]
    p [:pair_2, pair_2]
    
    a_gap = gap(a1, a2)
    b_gap = gap(b1, b2)
    
    p [:a_gap, a_gap]
    p [:b_gap, b_gap]
    
    if a_gap and !b_gap
      # deletion
      puts "Deletion from A: #{highlight(a_in, a_gap)}"
    elsif b_gap and !a_gap
      # addition
      puts "Addition to B: #{highlight(b_in, b_gap)}"
    elsif a_gap and b_gap
      # change
      puts "Change: #{highlight(a_in, a_gap)} -> #{highlight(b_in, b_gap)}"
    else
      puts "nil"
    end
    
    puts
  end
  
end



#
# DiffLCS finds "same"-chunks for two strings. This method uses that output
# to create the kind of diff we're all familiar with, with "added",
# "removed", and "changed" markings.
# 
# Example:
#    >> a_stream, b_stream = diff("hello", "hullo there")
#
def diff(a_in, b_in)
  result = a_in.diff(b_in)
  
  p [a_in, b_in]
  
  # create an array of pairs of matches: [ [a,b], [a,b], ... ]
  sames = result[:matched_old].zip(result[:matched_new]).sort_by{|a,b| p [a,b] ; a.first }
  
  # create a null range as an endpoint
  sames = [ [-1...0, -1...0] ] + sames
  
  last_a, last_b = sames.last
  add_to_a = last_a.last < (a_in.size) ? (a_in.size...a_in.size) : nil
  add_to_b = last_b.last < (b_in.size) ? (b_in.size...b_in.size) : nil
  
  if add_to_a or add_to_b
    sames << [add_to_a, add_to_b]
  end
  
  a_stream = []
  b_stream = []
  
  puts "sames: #{sames.inspect}"
  
  sames.each_cons(2) do |pair_1, pair_2|
    a1, b1 = pair_1
    a2, b2 = pair_2
    
    a_gap = gap(a1, a2)
    b_gap = gap(b1, b2)

    p [:pair_1, pair_1]
    p [:pair_2, pair_2]
    p [:a_gap, a_gap]
    p [:b_gap, b_gap]
    
    if a_gap and !b_gap
      # deletion from A
      a_stream << [a_gap, :deleted]
    elsif b_gap and !a_gap
      # addition to B
      b_stream << [b_gap, :added]
    elsif a_gap and b_gap
      # change from A to B
      a_stream << [a_gap, :changed]
      b_stream << [b_gap, :changed]
    else
      # no gap!
      p [:no_gap]
    end
    
    a_stream << [a2, :same] if a_gap and a_in[a2] != ""
    b_stream << [b2, :same] if b_gap and b_in[b2] != ""
  end
  
  [a_stream, b_stream]  
end

  
def highlight_string(str, diff_stream)
  colormap = {
    :same => :white,
    :changed => :yellow,
    :deleted => :red,
    :added => :green,
  }

  result = str.dup
  
  diff_stream.reverse.each do |range, change_type|
    result[range] = result[range].send(colormap[change_type])
  end
  
  result
end

def highlight_sames(a_in,b_in)
  result = a_in.diff(b_in)
  sames = result[:matched_old].zip(result[:matched_new])
  
  a_stream = []
  b_stream = []
  
  sames.each_with_index do |pair, i|
    a, b = pair
    a_stream << [a, i]
    b_stream << [b, i]
  end

  [:a, :b].zip([a_in, b_in], [a_stream, b_stream]).each do |name, string, stream|
    print "#{name}: "
    copy = string.dup
    stream.sort_by{|r,i| r.first}.reverse.each do |range,i|
      #copy[range] = copy[range].green + "[#{i}]"
      copy[range] = "(#{copy[range]})[#{i}]"
    end
    puts copy
  end
  
end

def display_diff(a, b)
  highlight_sames(a,b)
  a_stream, b_stream = diff(a, b)
  puts "A: #{highlight_string(a, a_stream)}"
  puts "B: #{highlight_string(b, b_stream)}"
  puts "a_stream: #{a_stream.inspect}"
  puts "b_stream: #{b_stream.inspect}"
  puts
end


if $0 == __FILE__
  display_diff("hello", "hillo")
  display_diff("hello", "ahello")
  display_diff("hello", "hello there")
  display_diff("hello there", "hello")
  display_diff("hello", "hullo there")
  
end