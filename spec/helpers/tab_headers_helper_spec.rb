require 'spec_helper'
require 'nokogiri'

describe TabHeadersHelper do  
  shared_examples_for 'all tabs' do
    it 'should generate well formed html' do
      booleans = [true, false]
      
      booleans.each do |boolean|
        output = @method.call(@object, boolean)
        validated_output = Nokogiri::HTML output

        validated_output.errors.should be_empty
      end
    end
  end
  
  # context, object pairs
  contexts = [['article',   'article'   ],
              ['talk',      nil         ], #nil because talk_forum is not an object yet
              ['read',      'article'   ],
              ['edit',      'article'   ],
              ['history',   'article'   ],
              ['menu',      'article'   ]]
  
  contexts.each do |c|
    context "#{c.first}" do
      before(:each) do
        @method = helper.method("#{c.first}_tab".to_sym)
        @object = Factory.create(c.last.to_sym)
      end
      
      it_should_behave_like 'all tabs'
    end
  end
end