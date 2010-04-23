require 'spec_helper'

describe Revision do
  context 'sorting' do
    it 'find_all_ordered should return a sorted array' do
      revision_count = 20
      revision_count.times do
        Factory.create(:revision)
        sleep 1
      end
      
      sorted_list = Revision.find_all_ordered('DESC')
      
      list_index = 1
      sorted_list.each do |item|
        unless (list_index == revision_count)
          next_item = sorted_list[list_index]
          item.created_at.should be > next_item.created_at
          list_index = list_index + 1
        end
      end
      
      sorted_list = Revision.find_all_ordered
      
      list_index = 1
      sorted_list.each do |item|
        unless (list_index == revision_count)
          next_item = sorted_list[list_index]
          item.created_at.should be < next_item.created_at
          list_index = list_index + 1
        end
      end
    end
    
    it 'should raise an ArgumentError when the passed in parameter is not \'DESC\' or nil' do
      invalid_inputs = [1, 7, Object.new, StandardError, 'desc', 'nil', '']

      invalid_inputs.each do |input|
        lambda { Revision.find_all_ordered(input) }.should raise_error(ArgumentError)
      end

      valid_inputs = ['DESC', nil]

      valid_inputs.each do |input|
        lambda { Revision.find_all_ordered(input) }.should_not raise_error
      end
    end
  end
end