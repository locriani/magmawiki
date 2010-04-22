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
  end
end