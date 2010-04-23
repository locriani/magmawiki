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
    
    it 'should have an appropriate active-state class' do
      booleans = [true, false]
      
      booleans.each do |boolean|
        output = @method.call(@object, boolean)
        validated_output = Nokogiri::HTML output
        
        if true == boolean
          # If we pass in true to #is_active, it should be active
          # and it should not be inactive.  If both are true, we have a problem
          # with our classes.
          validated_output.css("div.active").should_not be_empty
          validated_output.css("div.inactive").should be_empty
        else
          # et vice versa
          validated_output.css("div.active").should be_empty
          validated_output.css("div.inactive").should_not be_empty
        end
      end
    end
    it 'should have an appropriate position class' do
      pending
    end
    
    it 'should link to the appropriate location' do
      pending
    end
  end
  
  #           ['context',   'object'    ]
  contexts = [['article',   'article'   ],
              ['talk',      'talk_forum'],
              ['read',      'article'   ],
              ['edit',      'article'   ],
              ['history',   'article'   ],
              ['star',      'article'   ],
              ['menu',      'article'   ]]
  
  contexts.each do |c|
    context c[0] do
      before(:each) do
        @method = helper.method("#{c[0]}_tab".to_sym)
        @object = Factory.create(c[1].to_sym)
      end
      
      it_should_behave_like 'all tabs'
    end
  end
end