require 'spec_helper'

describe Parser::MediaWiki do
  context 'linebreaks' do
    context '\'<br />\' tags' do
      it 'should not escape \'<br />\' tags' do
        text = 'some text with a <br /> in it'
        output = Parser::MediaWiki.new.parse(text)
      
        output.should be_include('<br />')
        output.should be_include('some text')
      end
      
      it 'should turn \'<br>\' tags into \' <br />\' tags' do
        text = 'some text with a <br> tag in it'
        output = Parser::MediaWiki.new.parse(text)
        
        output.should be_include('<br />')
        output.should_not be_include('<br>')
        output.should be_include('some text')
      end
    end
    
    context 'page linebreaks' do
      it 'should turn two consecutive newlines into a new paragraph' do
        text = "test\ntest"
        
        output = Parser::MediaWiki.new.parse(text)        
        output.should be_eql("<p>test\ntest</p>")        
      end
      
      it 'should turn multiple consecutive linebreaks into something what the fuck is the parser doing here' do
        text = "test\n\n\n\n\ntest"
        
        output = Parser::MediaWiki.new.parse(text)
        output.should be_eql("<p>test\n</p><p><br />\n</p><p><br />\ntest\n</p>")
      end
    end
    
    context 'headers' do
      it 'should turn \'=Something=\' into \'<h1>Something</h1>\'' do
        text = "=Something="
        output = Parser::MediaWiki.new.parse(text)
        Logger.new(STDERR).info('something') { output }
  
        output.should be_eql("<p><h1>Something</h1></p>")
      end
      it 'should turn \'===Something===\' into \'<h3>Something</h3>\'' do
        text = "===Something==="
        output = Parser::MediaWiki.new.parse(text)
        Logger.new(STDERR).info('something') { output }
  
        output.should be_eql("<p><h3>Something</h3></p>")
      end
    end
  end
end